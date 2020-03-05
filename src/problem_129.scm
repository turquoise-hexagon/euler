(define (a n)
  (if (= (gcd n 10) 1)
      (do ((x 1 (remainder (add1 (* x 10)) n))
           (acc 1 (add1 acc)))
        ((zero? x) acc))
      0))

(define (main n)
  (do ((x n (+ x 2)))
    ((> (a x) n) x)))

(display (main 1000001))
(newline)
