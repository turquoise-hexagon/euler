(import (srfi 1))

(define (main n)
  (let ((lst (iota n 1 1)))
    (- (let ((tmp (apply + lst)))
         (* tmp tmp))
       (apply + (map
                  (lambda (x)
                    (* x x))
                  lst)))))

(display (main 100))
(newline)
