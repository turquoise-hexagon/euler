(import euler)

(define (cube x)
  (* x x x))

(define (main n)
  (let helper ((x 1) (acc 0))
    (let ((tmp (- (cube (add1 x)) (cube x))))
      (if (> tmp n)
          acc
          (helper (add1 x)
                  (if (prime? tmp)
                      (add1 acc)
                      acc))))))

(display (main 1000000))
(newline)
