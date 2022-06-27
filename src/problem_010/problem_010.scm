(import
  (euler))

(define (solve n)
  (foldl + 0 (primes n)))

(print (solve 2000000))
