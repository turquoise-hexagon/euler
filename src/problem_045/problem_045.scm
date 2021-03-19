(define (pentagonal? n)
  (integer? (/ (+ (sqrt (+ (* 24 n) 1)) 1) 6)))

(define (solve)
  (let solve/h ((i 144))
    (let ((t (* i (+ i i -1))))
      (if (pentagonal? t)
          t
          (solve/h (+ i 1))))))

(print (solve))
