(define // quotient)

(define (solve a b n)
  (let ((a (numerator a)) (b (denominator a))
        (c (numerator b)) (d (denominator b)))
    (let loop ((a a) (b b) (x (// n b)) (y (- n 1)) (acc 0))
      (if (and (= x c)
               (= y d))
        acc
        (let ((_ (// (+ n b) y)))
          (loop x y
            (- (* _ x) a)
            (- (* _ y) b)
            (+ acc 1)))))))
    
(print (solve 1/3 1/2 12000))
