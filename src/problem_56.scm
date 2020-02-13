(import euler
        (srfi 1))

(define (main n)
  (apply max
         (map
           (lambda (x)
             (apply max
                    (map
                      (lambda (y)
                        (digitsum (expt x y)))
                      (iota n 1 1))))
           (iota n 1 1))))

(display (main 100))
(newline)
