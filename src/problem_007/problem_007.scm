(import (euler))

(define (solve n)
  (let solve/h ((i 0) (cnt 0))
    (let ((cnt (if (prime? i)
                   (+ cnt 1)
                   cnt)))
      (if (= cnt n)
          i
          (solve/h (+ i 1) cnt)))))

(print (solve 10001))
