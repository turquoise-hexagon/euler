(import (euler))

(define (solve n)
  (let solve/h ((num 3) (den 2) (i 0) (acc 0))
    (if (> i n) acc
        (let* ((num (+ num den den)) (den (- num den)))
          (solve/h num den (+ i 1) (if (> (length (number->list num))
                                          (length (number->list den)))
                                       (+ acc 1)
                                       acc))))))

(print (solve 1000))
