(import (math number-theory))

(define (main n)
  (do ((t 0 (add1 t))
       (x 0 (+ t x)))
    ((> (length (divisors x)) n) x)))

(display (main 500))
(newline)
