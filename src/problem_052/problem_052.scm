(import (chicken sort)
        (euler)
        (srfi 1))

(define (generate-key n)
  (sort (number->list n) <))

(define (valid? n muls)
  (let ((lst (generate-key n)))
    (foldl
      (lambda (acc a)
        (and (equal? (generate-key (* n a)) lst) acc))
      #t muls)))

(define (solve muls)
  (let solve/1/h ((i 1))
    (if (valid? i muls) i
        (solve/1/h (+ i 1)))))

(print (solve '(2 3 4 5 6)))
