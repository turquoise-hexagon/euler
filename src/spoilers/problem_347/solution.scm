(import
  (euler)
  (srfi 69))

(define (factors limit)
  (let ((acc (make-vector (+ limit 1) '())))
    (for-each
      (lambda (prime)
        (let loop ((multiple prime))
          (unless (> multiple limit)
            (vector-set! acc multiple
              (cons prime (vector-ref acc multiple)))
            (loop (+ multiple prime)))))
      (primes limit))
    acc))

(define (solve limit)
  (let ((acc (make-hash-table)) (factors (factors limit)))
    (let loop ((i 0))
      (unless (> i limit)
        (let ((_ (vector-ref factors i)))
          (when (= (length _) 2)
            (hash-table-set! acc _ i)))
        (loop (+ i 1))))
    (foldl + 0 (hash-table-values acc))))

(print (solve 10000000))
