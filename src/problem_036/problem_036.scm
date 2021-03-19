(import (euler)
        (srfi 1))

(define (is-valid? n)
  (and (palindrome? n  2)
       (palindrome? n 10)))

(define (solve)
  (apply + (filter is-valid? (iota 1000000))))

(print (solve))
