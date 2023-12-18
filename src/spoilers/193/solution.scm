(import
  (euler)
  (chicken fixnum))

(define (make-moebius l)
  (let ((acc (make-vector (fx+ l 1) 1)))
    (for-each
      (lambda (p)
        (let ((s (fx* p p)))
          (do ((m p (fx+ m p))) ((fx> m l))
            (vector-set! acc m (fx* (vector-ref acc m) -1)))
          (do ((m s (fx+ m s))) ((fx> m l))
            (vector-set! acc m 0))))
      (primes l))
    (lambda (n)
      (vector-ref acc n))))

(define (solve l)
  (let ((moebius (make-moebius (fxsqrt l))))
    (let loop ((i 1) (acc 0))
      (let ((_ (fx* i i)))
        (if (fx> _ l)
          acc
          (loop (fx+ i 1) (fx+ acc (fx* (fx/ l _) (moebius i)))))))))

(let ((_ (solve (fxexpt 2 50))))
  (print _) (assert (= _ 684465067343069)))
