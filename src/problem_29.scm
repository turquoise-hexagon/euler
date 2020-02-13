(import (srfi 69))

(define (main n)
  (let ((hash (make-hash-table)))
    (do ((x 2 (add1 x))) ((> x n))
      (do ((y 2 (add1 y))) ((> y n))
        (hash-table-set! hash (expt x y) #t)))
    (hash-table-size hash)))

(display (main 100))
(newline)
