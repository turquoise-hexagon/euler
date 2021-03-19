(import (euler))

(define (cube n)
  (* n n n))

(define (solve n)
  (let solve/h ((i 0) (acc 0))
    (let ((tmp (- (cube (+ i 1)) (cube i))))
      (let ((acc (if (prime? tmp)
                     (+ acc 1)
                     acc)))
        (if (> tmp n) acc
            (solve/h (+ i 1) acc))))))

(print (solve 1000000))
