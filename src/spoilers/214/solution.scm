(import
  (euler)
  (srfi 69))

(define (make-phi primes limit)
  (let ((acc (make-vector (+ limit 1))))
    (let loop ((i 0))
      (unless (> i limit)
        (vector-set! acc i i)
        (loop (+ i 1))))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (> m limit)
            (vector-set! acc m (* (vector-ref acc m) (- 1 (/ 1 p))))
            (loop (+ m p)))))
      primes)
    (define (phi n)
      (vector-ref acc n))
    phi))

(define (make-chain primes limit)
  (let ((acc (make-hash-table)) (phi (make-phi primes limit)))
    (hash-table-set! acc 1 1)
    (define (chain n)
      (if (hash-table-exists? acc n)
        (hash-table-ref acc n)
        (let ((_ (+ (chain (phi n)) 1)))
          (hash-table-set! acc n _)
          _)))
    chain))

(define (solve limit chain-length)
  (let* ((primes (primes limit)) (chain (make-chain primes limit)))
    (foldl
      (lambda (acc i)
        (if (= (chain i) chain-length)
          (+ acc i)
          acc))
      0 primes)))

(let ((_ (solve #e4e7 25)))
  (print _) (assert (= _ 1677366278943)))
