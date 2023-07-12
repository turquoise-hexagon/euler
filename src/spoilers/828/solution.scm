(import
  (chicken io)
  (chicken sort)
  (chicken string)
  (euler)
  (srfi 1)
  (srfi 69))

(define operators (list + - * /))

(define (parse-input str)
  (apply
    (lambda (target . numbers)
      (list target (sort numbers >)))
    (map string->number (string-split str ":,"))))

(define (import-input)
  (map parse-input (read-lines)))

(define (id target numbers) ;; make caching easier
  (string-intersperse (map number->string (cons target numbers)) ":"))

(define valid?
  (let ((cache (make-hash-table)))
    (lambda (target numbers)
      (let ((id (id target numbers)))
        (cond
          ((hash-table-exists? cache id)
           (hash-table-ref cache id))
          ((null? numbers)
           #f)
          ((null? (cdr numbers))
           (= (car numbers) target))
          (else
           (let loop ((operands (combinations numbers 2)))
             (if (null? operands)
               #f
               (apply
                 (lambda (a b)
                   (let subloop ((operators operators))
                     (if (null? operators)
                       (loop (cdr operands))
                       (let ((value ((car operators) a b)))
                         (if (and (> value 0) (integer? value))
                           (let* ((numbers (delete-first numbers a))
                                  (numbers (delete-first numbers b))
                                  (numbers (sort (cons value numbers) >)))
                             (let ((result (valid? target numbers)))
                               (hash-table-set! cache id result)
                               (if result result
                                 (subloop (cdr operators)))))
                           (subloop (cdr operators)))))))
                 (car operands))))))))))

(define (countdown target numbers)
  (let ((result (map
                  (lambda (result)
                    (apply + result))
                  (filter
                    (lambda (numbers)
                      (valid? target numbers))
                    (powerset numbers)))))
    (if (null? result) 0
      (apply min result))))

(define (solve input mod)
  (modulo
    (apply +
      (map
        (lambda (problem index)
          (* (expt 3 index) (apply countdown problem)))
        input (range 1 (length input))))
    mod))

(let ((_ (solve (import-input) 1005075251)))
  (print _) (assert (= _ 148693670)))
