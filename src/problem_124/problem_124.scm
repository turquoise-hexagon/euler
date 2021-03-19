(import (chicken sort)
        (euler)
        (srfi 1))

(define (rad n)
  (apply * (delete-duplicates (factorize n) =)))

(define (solve a b)
  (car (list-ref (sort
                   (map
                     (lambda (i)
                       (cons i (rad i)))
                     (iota a 1))
                   (lambda (a b)
                     (< (cdr a) (cdr b))))
                 (- b 1))))

(print (solve 100000 10000))
