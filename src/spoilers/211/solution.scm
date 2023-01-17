(define (sums n)
  (let ((acc (make-vector (+ n 1) 0)))
    (do ((i 1 (+ i 1))) ((> i n))
      (do ((j i (+ j i))) ((> j n))
        (vector-set! acc j (+ (vector-ref acc j) (* i i)))))
    acc))

(define (solve n)
  (let ((sums (sums n)))
    (let loop ((i 0) (acc 0))
      (if (> i n)
        acc
        (loop (+ i 1)
          (if (integer? (sqrt (vector-ref sums i)))
            (+ acc i)
            acc))))))

(let ((_ (solve #e64e6)))
  (print _) (assert (= _ 1922364685)))
