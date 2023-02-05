(import
  (euler))

(define (solve n l)
  (foldl
    (lambda (acc p)
      (if (= (gcd n p) 1)
        (+ acc (modular-inverse n p))
        acc))
    0 (primes l)))

(let ((_ (solve 10 #e1e7)))
  (print _) (assert (= _ 1601912348822)))
