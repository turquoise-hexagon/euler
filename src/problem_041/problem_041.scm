(import (euler)
        (srfi 1))

(define (list->number lst)
  (string->number (apply string-append (map number->string lst))))

(define (solve)
  (apply max (filter prime? (map list->number (append-map permutations (map (cut iota <> 1) (iota 9 1)))))))

(print (solve))
