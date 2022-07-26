(define (solve n)
  (let loop ((i 3) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1)
        (+ acc (* 2 i (quotient (- i 1) 2)))))))

(print (solve 1000))
