(import
  (euler)
  (srfi 69))

(define (make-generate n)
  (let-values (((root _) (exact-integer-sqrt n)))
    (let ((primes (primes root)) (limit n))
      (define (generate exponent)
        (let loop ((lst primes) (acc '()))
          (if (null? lst)
            acc
            (let ((_ (expt (car lst) exponent)))
              (if (> _ limit)
                acc
                (loop (cdr lst) (cons _ acc)))))))
      generate)))

(define (solve n)
  (let ((generate (make-generate n)) (acc (make-hash-table)))
    (for-each
      (lambda (lst)
        (let ((_ (apply + lst)))
          (unless (> _ n)
            (hash-table-set! acc _ #t))))
      (product
        (generate 2)
        (generate 3)
        (generate 4)))
    (hash-table-size acc)))

(let ((_ (solve #e5e7)))
  (print _) (assert (= _ 1097343)))
