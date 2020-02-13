(define (main n)
  (do ((x 3 (add1 x))
       (acc 0 (+ acc (* 2 x (quotient (sub1 x) 2)))))
    ((> x n) acc)))

(display (main 1000))
(newline)
