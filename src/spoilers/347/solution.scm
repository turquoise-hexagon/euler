(import
  (chicken fixnum)
  (euler))

(define (make-compute n)
  (let ((acc/1 (make-vector (fx+ n 1) 0))
        (acc/2 (make-vector (fx+ n 1) 1)))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m n)
            (vector-set! acc/1 m (fx+ (vector-ref acc/1 m) 1))
            (vector-set! acc/2 m (fx* (vector-ref acc/2 m) p))
            (loop (fx+ m p)))))
      (primes n))
    (define (compute n)
      (values
        (vector-ref acc/1 n)
        (vector-ref acc/2 n)))
    compute))

(define (solve n)
  (let ((mem (make-vector (fx+ n 1) 0)) (compute (make-compute n)))
    (let loop ((i 0))
      (unless (fx> i n)
        (let-values (((c p) (compute i)))
          (when (fx= c 2)
            (vector-set! mem p i)))
        (loop (fx+ i 1))))
    (let loop ((i 0) (acc 0))
      (if (fx> i n)
        acc
        (loop (fx+ i 1) (fx+ acc (vector-ref mem i)))))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 11109800204052)))
