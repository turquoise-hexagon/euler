(import (euler)
        (chicken sort)
        (srfi 1))

(define (convert lst)
  (apply string-append (map number->string lst)))

(define (solve n)
  (list-ref (sort (map convert (permutations (iota 10))) string<?) (- n 1)))

(print (solve 1000000))
