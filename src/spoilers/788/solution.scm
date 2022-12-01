(define (factorials n)
  (let ((acc (make-vector (+ n 1) 1)))
    (let loop ((i 1))
      (if (> i n)
        acc
        (begin
          (vector-set! acc i (* (vector-ref acc (- i 1)) i))
          (loop (+ i 1)))))))

(define (choose factorials a b)
  (let ((a (vector-ref factorials a))
        (b (vector-ref factorials b))
        (t (vector-ref factorials (- a b))))
    (/ a (* b t))))

(define (a factorials n)
  (let loop ((i (+ (quotient n 2) 1)) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1)
        (let ((_ (* (choose factorials n i) (expt 9 (- n i -1)))))
          (+ acc _))))))

(define (solve n)
  (let ((factorials (factorials n)))
    (let loop ((i 1) (acc 0))
      (if (> i n)
        acc
        (loop (+ i 1) (+ acc (a factorials i)))))))

(print (modulo (solve 2022) 1000000007))
