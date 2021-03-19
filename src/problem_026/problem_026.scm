(import (chicken sort)
        (euler)
        (srfi 1))

(define (solve n)
  (caar (sort (map
                (lambda (i)
                  (cons i (discrete-log 10 1 i)))
                (iota n 1))
              (lambda (a b)
                (apply > (map cdr (list a b)))))))

(print (solve 1000))
