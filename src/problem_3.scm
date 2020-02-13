(define (main n)
  (let helper ((a 2) (b n))
    (cond ((> (* a a) b)
           b)
          ((zero? (remainder b a))
           (helper a (quotient b a)))
          (else
           (helper (add1 a) b)))))

(display (main 600851475143))
(newline)
