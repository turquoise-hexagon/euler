(import
  (euler))

(define (solve n)
  (extremum (primes n) (lambda (i) (discrete-log 10 1 i)) >))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 983)))
