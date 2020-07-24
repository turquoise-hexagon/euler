(import (euler))

(define (main n)
  (do ((lst (sieve n) (cdr lst))
       (acc 1 (* acc (car lst))))
    ((> (* acc (car lst)) n) acc)))

(display (main 1000000))
(newline)
