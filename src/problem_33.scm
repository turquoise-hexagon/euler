(define (main)
  (let ((dp 1) (np 1))
    (do ((i 1 (add1 i))) ((> i 9))
      (do ((j 1 (add1 j))) ((= j i))
        (do ((k 1 (add1 k))) ((= k j))
          (cond ((= (* (+ (* k 10) i) j)
                         (* (+ (* i 10) j) k))
                 (begin
                   (set! np (* np k))
                   (set! dp (* dp j))))))))
    (quotient dp (gcd np dp))))

(display (main))
(newline)
