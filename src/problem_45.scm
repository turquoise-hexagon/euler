(define (pentagonal? n)
  (integer? (/ (+ (sqrt (+ (* 24 n) 1)) 1) 6)))

(define (main)
  (let helper ((x 144))
    (let ((tmp (* x (sub1 (* 2 x)))))
      (if (pentagonal? tmp)
          tmp
          (helper (add1 x))))))

(display (main))
(newline)
