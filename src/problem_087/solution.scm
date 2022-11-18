(import
  (euler)
  (srfi 69)
  (srfi 1))

(define (generate primes limit exponent)
  (let loop ((primes primes) (acc '()))
    (let ((tmp (expt (car primes) exponent)))
      (if (> tmp limit)
        acc
        (loop (cdr primes) (cons tmp acc))))))

(define (solve n)
  (let ((primes (primes n)) (acc (make-hash-table)))
    (for-each
      (lambda (triplet)
        (hash-table-set! acc (apply + triplet) #t))
      (apply product
        (map
          (lambda (exponent)
            (generate primes n exponent))
          '(2 3 4))))
    (count
      (lambda (i)
        (< i n))
      (hash-table-keys acc))))

(print (solve 50000000))
