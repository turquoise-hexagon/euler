(import euler)

(define (a n)
  (if (= (gcd n 10) 1)
      (do ((x 1 (remainder (add1 (* x 10)) n))
           (acc 1 (add1 acc)))
        ((zero? x) acc))
      0))

(define (main n)
  (let helper ((x 5) (y 0) (acc 0))
    (if (= y n)
        acc
        (let ((t (a x)))
          (if (or (zero? t)
                  (prime? x)
                  (not (zero? (remainder (sub1 x) t))))
              (helper (add1 x) y acc)
              (helper (add1 x) (add1 y) (+ acc x)))))))

(display (main 25))
(newline)
