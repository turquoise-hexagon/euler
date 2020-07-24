(import (euler))

(define (cube n)
  (* n n n))

(define (main n)
  (do ((x 1 (add1 x))
       (tmp 0 (- (cube (add1 x)) (cube x)))
       (acc 0 (if (prime? tmp)
                  (add1 acc)
                  acc)))
    ((> tmp n) acc)))

(display (main 1000000))
(newline)
