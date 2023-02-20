(import
  (chicken fixnum)
  (euler))

(define (make-phi primes limit)
  (let ((acc (make-vector (fx+ limit 1))))
    (do ((i 0 (fx+ i 1))) ((fx> i limit))
      (vector-set! acc i i))
    (for-each
      (lambda (i)
        (do ((m i (fx+ m i))) ((fx> m limit))
          (let ((_ (vector-ref acc m)))
            (vector-set! acc m (fx- _ (fx/ _ i))))))
      primes)
    (define (phi n)
      (vector-ref acc n))
    phi))

(define (make-chain primes limit)
  (let ((acc (make-vector (fx+ limit 1) #f)) (phi (make-phi primes limit)))
    (vector-set! acc 1 1)
    (define (chain n)
      (let ((_ (vector-ref acc n)))
        (if _ _
          (let ((_ (fx+ (chain (phi n)) 1)))
            (vector-set! acc n _)
            _))))
    chain))

(define (solve limit chain-length)
  (let* ((primes (primes limit)) (chain (make-chain primes limit)))
    (foldl
      (lambda (acc i)
        (if (fx= (chain i) chain-length)
          (fx+ acc i)
          acc))
      0 primes)))

(let ((_ (solve #e4e7 25)))
  (print _) (assert (= _ 1677366278943)))
