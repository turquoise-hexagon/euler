(import
  (euler)
  (srfi 1))

(define (solve n)
  (apply +
    (filter
      (lambda (p)
        (not (= (modular-expt 10 #e1e16 (* 9 p)) 1)))
      (primes n))))

(let ((_ (solve #e1e5)))
  (print _) (assert (= _ 453647705)))
