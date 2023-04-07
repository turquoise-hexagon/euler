(import
  (chicken fixnum)
  (euler))

(define-constant l #e15e3)

(define divisors-count
  (let ((acc (make-vector (fx+ l 1) 1)))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m l)
            (let loop ((i m) (tmp 1))
              (if (fx= (fxmod i p) 0)
                (loop (fx/ i p) (fx+ tmp 1))
                (vector-set! acc m (fx* (vector-ref acc m) tmp))))
            (loop (fx+ m p)))))
      (primes l))
    (lambda (n)
      (vector-ref acc n))))

(define (divisors-count/triangle n)
  (let ((_ (fx+ n 1)))
    (if (fxeven? n)
      (fx* (divisors-count _)
           (divisors-count (fx/ n 2)))
      (fx* (divisors-count n)
           (divisors-count (fx/ _ 2))))))

(define (triangle n)
  (fx/ (fx* n (fx+ n 1)) 2))

(define (solve n)
  (let loop ((i 1))
    (if (fx> (divisors-count/triangle i) n)
      (triangle i)
      (loop (fx+ i 1)))))

(let ((_ (solve 500)))
  (print _) (assert (= _ 76576500)))
