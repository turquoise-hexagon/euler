(define (main)
  (define (helper a b)
    (let ((b (min b (- a b))))
      (do ((x 1 (add1 x))
           (acc 1 (/ (* acc (+ (- a b) x)) x)))
;           (acc 1 (let ((tmp (* acc (+ (- a b) x))))
;                    (/ tmp x))))
        ((> x b) acc))))
  (- (+ (helper (+ 100 10) 10)
        (helper (+ 100  9)  9))
     (* 10 100)
     2))
 
(display (main))
(newline)
