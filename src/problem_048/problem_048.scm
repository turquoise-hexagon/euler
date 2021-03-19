(import (srfi 1))

(define (solve n)
  (modulo (apply + (map (lambda (i) (expt i i)) (iota 1000 1))) (expt 10 n)))

(print (solve 10))
