(import
  (euler))

(define (solve n)
  (foldl + 0 (primes n)))

(let ((_ (solve #e2e6)))
  (print _) (assert (= _ 142913828922)))
