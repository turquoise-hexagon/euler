(import (srfi 1))

(define (solve n)
  (let ((lst (iota n)))
    (- (expt (apply + lst) 2) (apply + (map (cut expt <> 2) lst)))))

(print (solve 100))
