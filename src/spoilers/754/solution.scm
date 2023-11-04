(import
  (chicken fixnum)
  (euler))

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

(define (modular-expt b e m)
  (let loop ((b b) (e e) (acc 1))
    (if (fx= e 0)
      acc
      (loop (fxmod (fx* b b) m) (fx/ e 2)
        (if (fxodd? e)
          (fxmod (fx* b acc) m)
          acc)))))

(define (solve l m)
  (let ((moebius (make-moebius l)) (mem (make-vector (fx+ l 1) 0)))
    (do ((i 1 (fx+ i 1))) ((fx> i l))
      (let ((v (moebius i)))
        (unless (fx= v 0)
          (do ((j i (fx+ j i))) ((fx> j l))
            (vector-set! mem j (fx+ (vector-ref mem j) (fx* v (fx/ (fx- l j) i))))))))
    (do ((i 1 (fx+ i 1))
         (acc 1 (fxmod (fx* acc (modular-expt i (vector-ref mem i) m)) m)))
      ((fx> i l) acc))))

(let ((_ (solve #e1e8 1000000007)))
  (print _) (assert (= _ 785845900)))
