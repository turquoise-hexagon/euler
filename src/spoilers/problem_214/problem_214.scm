(import
  (euler)
  (srfi 1))

(define (factors primes n)
  (let ((acc (make-vector (+ n 1) '())))
    (for-each
      (lambda (p)
        (do ((m p (+ m p))) ((> m n))
          (let ((_ (vector-ref acc m)))
            (vector-set! acc m (cons p _)))))
      primes)
    acc))

(define (make-phi primes n)
  (let ((factors (factors primes n)))
    (lambda (n)
      (foldl * n
        (map
          (lambda (_)
            (- 1 (/ 1 _)))
          (vector-ref factors n))))))

(define (make-chain primes n)
  (let ((phi (make-phi primes n)))
    (lambda (n)
      (let loop ((i n) (acc 1))
        (if (= i 1)
          acc
          (loop (phi i) (+ acc 1)))))))

(define (solve limit chain-length)
  (let* ((primes (primes limit)) (chain (make-chain primes limit)))
    (foldl + 0
      (filter
        (lambda (_)
          (= (chain _) chain-length))
        primes))))

(print (solve 40000000 25))
