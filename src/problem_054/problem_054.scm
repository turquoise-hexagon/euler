(import
  (chicken io)
  (chicken string)
  (chicken sort)
  (matchable)
  (srfi 1))

(define cards
  '(("T" 10)
    ("J" 11)
    ("Q" 12)
    ("K" 13)
    ("A" 14)))

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
  (match (string-chop str 1)
    ((value suit)
     (let ((temp (string->number value)))
       (if temp (list temp suit)
           (match (assoc value cards)
             ((_ value) (list value suit))))))))

(define (parse-line str)
  (let ((lst (map parse-card (string-split str " "))))
    (list (take lst 5)
          (drop lst 5))))

(define (import-input)
  (map parse-line (read-lines)))

(define (repetitions lst)
  (fold
    (lambda (card acc)
      (match card
        ((value _)
         (let ((query (assoc value acc)))
           (match query
            ((_ count)
             (cons (list value (+ count 1)) (delete query acc)))
            (_ (cons (list value 1) acc)))))))
    '() lst))

(define (tuple lst)
  (let ((reps (repetitions lst)))
    (let ((keys (map car  reps))
          (vals (map cadr reps)))
      (list (sort vals >)
            (sort keys
                  (lambda (a b)
                    (match-let
                     (((_ av) (assoc a reps))
                      ((_ bv) (assoc b reps)))
                     (if (= av bv) (> a b)
                         (> av bv)))))))))

(define (compare a b)
  (call/cc
    (lambda (return)
      (define (compare/h a b)
        (for-each
          (lambda (a b)
            (cond ((> a b) (return 1))
                  ((< a b) (return 2))))
          a b))
      (match-let
        (((a1 a2) a)
         ((b1 b2) b))
        (compare/h a1 b1)
        (compare/h a2 b2)))))

(define (rank lst)
  (match (tuple lst)
    ((reps _)
     (list-index (cut equal? <> reps) ranks))))

(define (straight? lst)
  (let ((lst (sort (map car lst) <)))
    (equal? lst (iota (length lst) (car lst)))))

(define (flush? lst)
  (let ((lst (delete-duplicates (map cadr lst) string=?)))
    (= (length lst) 1)))

(define (special-value lst)
  (let ((score (rank lst)))
    (let ((score (if (flush? lst)
                     5
                     score)))
      (cond ((straight? lst)
             (if (= score 5)
                 8
                 4))
            (else score)))))

(define (winner lst)
  (match lst
    ((a b)
     (let ((av (special-value a))
           (bv (special-value b)))
       (cond ((> av bv) 1)
             ((< av bv) 2)
             (else (compare (tuple a)
                            (tuple b))))))))

(define (solve input)
  (count (cut = <> 1) (map winner input)))

(print (solve (import-input)))
