(import
  (chicken fixnum)
  (euler))

(define (make-number-divisors n)
  (let ((acc (make-vector (fx+ n 1) 1)))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m n)
            (let subloop ((i m) (tmp 0))
              (if (fx= (fxmod i p) 0)
                (subloop (fx/ i p) (fx+ tmp 1))
                (vector-set! acc m (fx* (vector-ref acc m) (fx+ 1 tmp)))))
            (loop (fx+ m p)))))
      (primes n))
    (define (number-divisors n)
      (vector-ref acc n))
    number-divisors))

(define (solve n)
  (let ((number-divisors (make-number-divisors n)))
    (let loop ((i 2) (acc 0))
      (if (fx> i n)
        acc
        (loop (fx+ i 1)
          (if (fx= (number-divisors i)
                   (number-divisors (fx- i 1)))
            (fx+ acc 1)
            acc))))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 986262)))
