(import (srfi 1))

(define (solve n)
  (apply + (filter
             (lambda (i)
               (or (= 0 (modulo i 3))
                   (= 0 (modulo i 5))))
             (iota n))))

(print (solve 1000))
