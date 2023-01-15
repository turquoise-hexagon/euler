(define (solve n)
  (let ((n (quotient n 2)))
    (/ (+ 3
          (* (* 2 n)
             (+ (* 8 n n)
                (* 15 n)
                13)))
       3)))

(let ((_ (solve 1001)))
  (print _) (assert (= _ 669171001)))
