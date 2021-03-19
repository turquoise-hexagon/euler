(import (srfi 1))

(define (solve n)
  (apply lcm (iota n 1)))

(print (solve 20))
