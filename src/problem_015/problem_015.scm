(import (euler))

(define (binomial-coefficient a b)
  (/ (factorial a) (* (factorial b) (factorial (- a b)))))

(define (solve n)
  (binomial-coefficient (+ n n) n))

(print (solve 20))
