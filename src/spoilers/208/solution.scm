(import
  (euler))

(define (f n i)
  (* (+ (- (expt n 4)
           (* 3 (expt n 3) i)
           (* 2 (expt i 3) n))
        (* 4 (expt n 2) (expt i 2))
        (expt i 4))
     (expt (binomial n i) 5)))

(define (solve n)
  (let ((n (quotient n 5)))
    (let loop ((i 0) (acc 0))
      (if (> i n)
        (quotient acc (expt n 4))
        (loop (+ i 1) (+ acc (f n i)))))))

(let ((_ (solve 70)))
  (print _) (assert (= _ 331951449665644800)))
