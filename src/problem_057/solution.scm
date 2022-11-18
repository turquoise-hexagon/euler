(import
  (euler))

(define (number-length n)
  (length (number->list n)))

(define (solve n)
  (let loop ((num 3) (den 2) (i 0) (acc 0))
    (if (> i n)
      acc
      (let* ((num (+ num den den)) (den (- num den)))
        (loop num den (+ i 1)
          (if (> (number-length num)
                 (number-length den))
            (+ acc 1)
            acc))))))

(print (solve 1000))
