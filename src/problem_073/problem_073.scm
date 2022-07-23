(define // quotient)

(define (solve x y n)
  (let loop ((a 1) (b x) (c (// n x)) (d (- n 1)) (acc 0))
    (if (and (= c 1)
             (= d y))
      acc
      (let ((_ (// (+ n b) d)))
        (loop c d
          (- (* _ c) a)
          (- (* _ d) b)
          (+ acc 1))))))
    
(print (solve 3 2 12000))
