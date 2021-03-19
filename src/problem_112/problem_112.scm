(import (chicken sort)
        (euler))

(define (bouncy? n)
  (let ((lst (number->list n)))
    (not (or (equal? lst (sort lst <))
             (equal? lst (sort lst >))))))

(define (solve n)
  (let ((n (/ n 100)))
    (let solve/h ((i 100) (acc 0))
      (let ((t (if (bouncy? i)
                   (+ acc 1)
                   acc)))
        (if (= (/ t i) n)
            i
            (solve/h (+ i 1) t))))))

(print (solve 99))
