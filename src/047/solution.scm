(import
  (chicken fixnum)
  (euler))

(define-constant limit #e5e5)

(define (make-number-factors n)
  (let loop ((acc (make-vector (fx+ n 1) 0)))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m n)
            (vector-set! acc m (fx+ (vector-ref acc m) 1))
            (loop (fx+ m p)))))
      (primes n))
    (define (number-factors n)
      (vector-ref acc n))
    number-factors))

(define (make-valid? n)
  (let ((number-factors (make-number-factors n)))
    (define (valid? n l)
      (let loop ((i 0))
        (if (fx= i l)
          #t
          (if (fx= (number-factors (fx+ n i)) l)
            (loop (fx+ i 1))
            #f))))
    valid?))

(define (solve l)
  (let ((valid? (make-valid? limit)))
    (let loop ((i 2))
      (if (valid? i l)
        i
        (loop (fx+ i 1))))))

(let ((_ (solve 4)))
  (print _) (assert (= _ 134043)))
