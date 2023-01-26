(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define (order n)
  (let loop ((i 1))
    (let ((_ (fx* i 10)))
      (if (fx> _ n)
        i
        (loop _)))))

(define (make-circular-prime? primes)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (_)
        (hash-table-set! acc _ #t))
      primes)
    (define (circular-prime? n)
      (let ((_ (order n)))
        (let loop ((i n) (n n))
          (if (fx= i 0)
            #t
            (if (hash-table-exists? acc n)
              (loop (fx/ i 10) (fx+ (fx* (fxmod n _) 10) (fx/ n _)))
              #f)))))
    circular-prime?))

(define (solve n)
  (let* ((primes (primes n)) (circular-prime? (make-circular-prime? primes)))
    (foldl
      (lambda (acc i)
        (if (circular-prime? i)
          (fx+ acc 1)
          acc))
      0 primes)))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 55)))
