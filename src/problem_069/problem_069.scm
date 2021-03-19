(import (euler))

(define (solve n)
  (let solve/h ((lst (primes n)) (acc 1))
    (let ((t (* acc (car lst))))
      (if (> t n)
          acc
          (solve/h (cdr lst) t)))))

(print (solve 1000000))
