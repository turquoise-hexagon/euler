(define (solve n)
  (- (expt (quotient (* n (+ n 1)) 2) 2)
     (quotient (* n (+ n 1) (+ (* 2 n) 1)) 6)))

(let ((_ (solve 100)))
  (print _) (assert (= _ 25164150)))
