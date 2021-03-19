(import (euler))

(define (solve n)
  (apply max (factorize n)))

(print (solve 600851475143))
