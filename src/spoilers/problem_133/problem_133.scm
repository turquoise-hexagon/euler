(import
  (euler)
  (srfi 1))

(define (solve n)
  (let ((_ (expt 10 16)))
    (apply +
      (filter
        (lambda (p)
          (not (= (expt-mod 10 _ (* 9 p)) 1)))
        (primes n)))))

(print (solve 100000))
