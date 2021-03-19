(define (sums n)
  (let ((sums (make-vector (+ n 1) 0)))
    (do ((i 1 (+ i 1))) ((> i n))
      (do ((j i (+ j i))) ((> j n))
        (vector-set! sums j (+ (vector-ref sums j) (* i i)))))
    sums))

(define (solve n)
  (let ((sums (sums n)))
    (let solve/h ((i 0) (acc 0))
      (if (> i n)
          acc
          (solve/h (+ i 1) (if (integer? (sqrt (vector-ref sums i)))
                               (+ acc i)
                               acc))))))

(print (solve 64000000))
