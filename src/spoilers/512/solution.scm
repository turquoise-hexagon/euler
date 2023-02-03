(import
  (chicken fixnum)
  (euler))

(define (make-phi n)
  (let ((primes (primes n)) (acc (make-vector (fx+ n 1))))
    (do ((i 0 (fx+ i 1))) ((fx> i n))
      (vector-set! acc i i))
    (for-each
      (lambda (p)
        (do ((m p (fx+ m p))) ((fx> m n))
          (vector-set! acc m (fx- (vector-ref acc m) (fx/ (vector-ref acc m) p)))))
      primes)
    (define (phi n)
      (vector-ref acc n))
    phi))

(define (solve n)
  (let ((phi (make-phi n)))
    (let loop ((i 1) (acc 0))
      (if (fx> i n)
        acc
        (loop (fx+ i 2) (fx+ acc (phi i)))))))

(let ((_ (solve #e5e8)))
  (print _) (assert (= _ 50660591862310323)))
