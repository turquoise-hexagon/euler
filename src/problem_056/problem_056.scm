(import (euler)
        (srfi 1))

(define (solve n)
  (apply max (map
               (lambda (lst)
                 (digitsum (apply (cut expt <> <>) lst)))
               (combinations (iota n) 2))))

(print (solve 100))
