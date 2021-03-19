(import (euler))

(define (solve n)
  (foldl (cut + <> <>) 0 (primes n)))

(print (solve 2000000))
