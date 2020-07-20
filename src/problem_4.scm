(import (euler))

(define (main n)
  (set! res 0)
  (do ((x 0 (add1 x))) ((= x n))
    (do ((y x (add1 y))) ((= y n))
      (let ((cur (* x y)))
        (when (and (palindrome? cur)
                   (> cur res))
          (set! res cur)))))
  res)

(display (main 1000))
(newline)
