(define (solve n)
  (let solve/h ((i 3) (acc 0))
    (if (> i n) acc
        (let ((acc (+ acc (* 2 i (quotient (- i 1) 2)))))
          (solve/h (+ i 1) acc)))))

(print (solve 1000))
