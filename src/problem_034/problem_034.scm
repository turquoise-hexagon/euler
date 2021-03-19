(import (euler)
        (srfi 1))

(define factorials
  (map factorial (iota 10)))

(define (is-valid? n)
  (= n (apply + (map
                  (cut list-ref factorials <>)
                  (number->list n)))))

(define (solve)
  (- (apply + (filter is-valid? (iota 1000000))) 3))

(print (solve))
