(import
  (euler))

(define (solve n l)
  (foldl + 0
    (map
      (lambda (i)
        (modular-inverse n i))
      (foldl delete-first (primes l) (factors n)))))

(let ((_ (solve 10 #e1e7)))
  (print _) (assert (= _ 1601912348822)))
