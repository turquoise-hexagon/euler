(import
  (euler)
  (srfi 69)
  (srfi 1))

(define (choose a b)
  (/ (factorial a) (* (factorial b) (factorial (- a b)))))

(define (square-free? n)
  (every
    (lambda (lst)
      (= (car lst) 1))
    (run-length (factorize n))))

(define (solve limit)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (n)
        (for-each
          (lambda (k)
            (let ((_ (choose n k)))
              (when (square-free? _)
                (hash-table-set! acc _ #t))))
          (range 0 n)))
      (range 1 limit))
    (apply + (hash-table-keys acc))))

(print (solve 50))