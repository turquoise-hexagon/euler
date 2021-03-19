(import (euler)
        (srfi 1)
        (srfi 69))

(define (generate lst n e)
  (let generate/h ((lst lst) (acc '()))
    (let ((t (expt (car lst) e)))
      (if (>= t n)
          (reverse acc)
          (generate/h (cdr lst) (cons t acc))))))

(define (solve n)
  (let ((lst (primes n)) (hash (make-hash-table)))
    (for-each
      (lambda (lst)
        (hash-table-set! hash (apply + lst) 0))
      (apply product (map (cut generate lst n <>) '(2 3 4))))
    (count (cut < <> n) (hash-table-keys hash))))

(print (solve 50000000))
