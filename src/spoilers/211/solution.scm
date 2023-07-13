(import
  (chicken fixnum)
  (euler))

(define (make-sigma2 l)
  (let ((acc (make-vector (fx+ l 1) 1)))
    (for-each
      (lambda (p)
        (let ((s (fx* p p)))
          (do ((m p (fx+ m p))) ((fx> m l))
            (do ((a p (fx* a p))
                 (b s (fx* b s))
                 (c 1 (fx+ c b)))
              ((fx> (fxmod m a) 0)
               (vector-set! acc m (fx* (vector-ref acc m) c)))))))
      (primes l))
    (lambda (n)
      (vector-ref acc n))))

(define (square? n)
  (let ((_ (fxsqrt n)))
    (fx= n (fx* _ _))))

(define (solve l)
  (let ((sigma2 (make-sigma2 l)))
    (do ((i 1 (fx+ i 1))
         (acc 0 (if (square? (sigma2 i))
                  (fx+ acc i)
                  acc)))
      ((fx> i l) acc))))

(let ((_ (solve #e64e6)))
  (print _) (assert (= _ 1922364685)))
