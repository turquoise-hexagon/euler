(import (euler))

(define (solve n)
  (digitsum (expt 2 n)))

(print (solve 1000))
