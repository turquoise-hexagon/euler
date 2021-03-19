(import (euler))

(define (solve n)
  (let solve/h ((a 1) (b 2))
    (if (> (length (divisors a)) n)
        a
        (solve/h (+ a b) (+ b 1)))))

(print (solve 500))
