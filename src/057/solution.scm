(import
  (euler))

(define (solve n)
  (let loop ((num 3) (den 2) (i 0) (acc 0))
    (if (> i n)
      acc
      (let* ((num (+ num den den)) (den (- num den)))
        (loop num den (+ i 1)
          (if (> (integer-log num)
                 (integer-log den))
            (+ acc 1)
            acc))))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 153)))
