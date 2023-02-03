(import
  (chicken fixnum)
  (euler))

(define (make-phi n)
  (let ((acc (make-vector (fx+ n 1) 1)))
    (do ((i 0 (fx+ i 1))) ((fx> i n))
      (vector-set! acc i i))
    (for-each
      (lambda (p)
        (do ((m p (fx+ m p))) ((fx> m n))
          (vector-set! acc m (fx- (vector-ref acc m) (fx/ (vector-ref acc m) p)))))
      (primes n))
    (define (phi n)
      (vector-ref acc n))
    phi))

(define (solve n)
  (let ((phi (make-phi n)))
    (do ((i 2 (fx+ i 1))
         (acc 0 (fx+ acc (phi i))))
      ((fx> i n) acc))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 303963552391)))
