(define (digit-count n)
  (do ((x n (quotient x 10))
       (acc 0 (add1 acc)))
    ((zero? x) acc)))

(define (main n)
  (do ((a 1 (+ a b))
       (b 0 a)
       (acc 1 (add1 acc)))
    ((equal? (digit-count a) n) acc)))

(display (main 1000))
(newline)
