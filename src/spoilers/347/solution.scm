(import
  (chicken fixnum)
  (euler))

(define (make-factors n)
  (let ((acc (make-vector (fx+ n 1) '())))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m n)
            (vector-set! acc m (cons p (vector-ref acc m)))
            (loop (fx+ m p)))))
      (primes n))
    (define (factors n)
      (vector-ref acc n))
    factors))

(define (solve n)
  (let ((mem (make-vector (fx+ n 1) 0)) (factors (make-factors n)))
    (let loop ((i 0))
      (unless (fx> i n)
        (let ((_ (factors i)))
          (when (fx= (length _) 2)
            (vector-set! mem (foldl fx* 1 _) i)))
        (loop (fx+ i 1))))
    (let loop ((i 0) (acc 0))
      (if (fx> i n)
        acc
        (loop (fx+ i 1) (fx+ acc (vector-ref mem i)))))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 11109800204052)))
