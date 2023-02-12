(import
  (euler)
  (srfi 1))

(define (solve n)
  (extremum
    (filter
      (lambda (i)
        (= (gcd 10 i) 1))
      (range 2 n))
    (lambda (i)
      (discrete-log 10 1 i))
    >))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 983)))
