(import
  (chicken fixnum)
  (euler))

(define-constant l #e15e3)

(define divisors-count
  (let ((acc (make-vector (fx+ l 1) 1)))
    (for-each
      (lambda (p)
        (do ((m p (fx+ m p))) ((fx> m l))
          (do ((i m (fx/ i p))
               (t 1 (fx+ t 1)))
            ((fx> (fxmod i p) 0)
             (vector-set! acc m (fx* (vector-ref acc m) t))))))
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
  (do ((i 1 (fx+ i 1)))
    ((fx> (divisors-count/triangle i) n)
     (triangle i))))

(let ((_ (solve 500)))
  (print _) (assert (= _ 76576500)))
