(import
  (euler)
  (srfi 69)
  (srfi 1))

(define (square-free? n)
  (every
    (lambda (lst)
      (= (car lst) 1))
    (run-length (factors n))))

(define (solve limit)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (n)
        (for-each
          (lambda (k)
            (let ((_ (binomial n k)))
              (when (square-free? _)
                (hash-table-set! acc _ #t))))
          (range 0 n)))
      (range 1 limit))
    (apply + (hash-table-keys acc))))

(let ((_ (solve 50)))
  (print _) (assert (= _ 34029210557338)))
