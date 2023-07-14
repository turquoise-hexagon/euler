(import
  (chicken fixnum)
  (euler))

(define (make-prime? primes limit)
  (let ((acc (make-vector (fx+ limit 1) #f)))
    (for-each
      (lambda (i)
        (vector-set! acc i #t))
      primes)
    (lambda (n)
      (vector-ref acc n))))

(define (order n)
  (let loop ((acc 1))
    (let ((_ (fx* acc 10)))
      (if (fx> _ n)
        acc
        (loop _)))))

(define (make-circular-prime? primes limit)
  (let ((prime? (make-prime? primes limit)))
    (lambda (n)
      (let ((_ (order n)))
        (let loop ((i n) (n n))
          (if (fx= i 0)
            #t
            (if (prime? n)
              (loop (fx/ i 10) (fx+ (fx* (fxmod n 10) _) (fx/ n 10)))
              #f)))))))

(define (solve limit)
  (let* ((primes (primes limit)) (circular-prime? (make-circular-prime? primes limit)))
    (foldl
      (lambda (acc i)
        (if (circular-prime? i)
          (fx+ acc 1)
          acc))
      0 primes)))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 55)))
