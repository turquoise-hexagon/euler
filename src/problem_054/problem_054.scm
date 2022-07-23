(import
  (chicken io)
  (chicken string)
  (chicken sort)
  (srfi 1)
  (srfi 69))

(define cards
  '(("T" . 10)
    ("J" . 11)
    ("Q" . 12)
    ("K" . 13)
    ("A" . 14)))

(define ranks
  '((1 1 1 1 1)
    (2 1 1 1)
    (2 2 1)
    (3 1 1)
    ()
    ()
    (3 2)
    (4 1)
    ()))

(define (parse-card str)
  (apply
    (lambda (value suit)
      (cond ((string->number value) number? =>
             (lambda (_) (cons _ suit)))
            ((assoc value cards) pair? =>
             (lambda (_) (cons (cdr _) suit)))))
    (string-chop str 1)))

(define (parse-line str)
  (let ((_ (map parse-card (string-split str " "))))
    (let-values (((a b) (split-at _ 5)))
      (list a b))))

(define (import-input)
  (map parse-line (read-lines)))

(define (repetitions lst)
  (foldl
    (lambda (acc card)
      (apply
        (lambda (value _)
          (cond ((assoc value acc) pair? =>
                 (lambda (_)
                   (cons (cons value (+ (cdr _) 1))
                     (delete _ acc))))
                (else (cons (cons value 1) acc))))
        card))
    '() lst))

(define (tuple lst)
  (let ((reps (repetitions lst)))
    (let ((_ (lambda (a b)
               (let ((x (cdr (assoc a reps)))
                     (y (cdr (assoc b reps))))
                 (if (= x y)
                   (> a b)
                   (> x y))))))
      (list (sort (map cdr reps) >)
            (sort (map car reps) _)))))

(define (compare a b)
  (call/cc
    (lambda (_)
      (for-each
        (lambda (a b)
          (for-each
            (lambda (a b)
              (cond
                ((> a b) (_ 1))
                ((< a b) (_ 2))))
            a b))
        a b))))

(define (rank lst)
  (apply
    (lambda (reps _)
      (list-index
        (lambda (_)
          (equal? _ reps))
        ranks))
    (tuple lst)))

(define (straight? lst)
  (let ((_ (sort (map car lst) <)))
    (equal? _ (iota (length _) (car _)))))

(define (flush? lst)
  (= (length (delete-duplicates (map cdr lst) string=?)) 1))

(define (special-value lst)
  (let* ((score (rank lst))
         (score (if (flush? lst)
                  5
                  score)))
    (cond ((straight? lst)
           (if (= score 5)
             8
             4))
          (else score))))

(define (winner lst)
  (apply
    (lambda (a b)
      (let ((x (special-value a))
            (y (special-value b)))
        (cond
          ((> x y) 1)
          ((< x y) 2)
          (else
            (compare
              (tuple a)
              (tuple b))))))
    lst))

(define (solve input)
  (count
    (lambda (_)
      (= _ 1))
    (map winner input)))

(let ((input (import-input)))
  (print (solve input)))
