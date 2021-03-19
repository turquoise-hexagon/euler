(import (euler)
        (srfi 1))

(define (exponents n)
  (map (cut expt <> n) (iota 10)))

(define (is-valid? n exponents)
  (= n (apply + (map
                  (cut list-ref exponents <>)
                  (number->list n)))))

(define (solve n)
  (let ((lst (exponents n)))
    (- (apply + (filter
                  (cut is-valid? <> lst)
                  (iota 1000000))) 1)))

(print (solve 5))
