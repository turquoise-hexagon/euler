(import (euler))

(define (solve n)
  (digitsum (factorial n)))

(print (solve 100))
