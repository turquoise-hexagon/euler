(import
  (euler)
  (srfi 1))

(define (solve n)
  (apply +
    (remove
      (lambda (i)
        (= (modular-expt 10 #e1e16 (* 9 i)) 1))
      (primes n))))

(let ((_ (solve #e1e5)))
  (print _) (assert (= _ 453647705)))
