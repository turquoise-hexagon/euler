(define (main n)
  (do ((x 1 (add1 x))
       (acc 0 (+ acc (expt x x))))
    ((> x n) (remainder acc (expt 10 10)))))

(display (main 1000))
(newline)
