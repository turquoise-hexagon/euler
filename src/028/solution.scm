(define (solve n)
  (let ((n (quotient n 2)))
    (/ (+ 3
          (* (* 2 n)
             (+ (* 8 n n)
                (* 15 n)
                13)))
       3)))

(print (solve 1001))
