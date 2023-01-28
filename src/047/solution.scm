(import
  (chicken fixnum)
  (euler))

(define (make-factors n)
  (let ((acc (make-vector (fx+ n 1) '())))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m n)
            (let subloop ((i m) (tmp 1))
              (if (fx= (fxmod i p) 0)
                (subloop (fx/ i p) (fx* tmp p))
                (vector-set! acc m (cons tmp (vector-ref acc m)))))
            (loop (fx+ m p)))))
      (primes n))
    (define (factors n)
      (vector-ref acc n))
    factors))

(define (make-valid? n)
  (let ((factors (make-factors n)))
    (define (valid? n l)
      (let loop ((i 0) (acc '()))
        (if (fx= i l)
          (fx= (length acc) (fx* l l))
          (loop (fx+ i 1)
            (foldl
              (lambda (acc f)
                (if (member f acc)
                  acc
                  (cons f acc)))
              acc (factors (fx+ n i)))))))
    valid?))

(define (solve n)
  (let ((valid? (make-valid? #e5e5)))
    (let loop ((i 2))
      (if (valid? i n)
        i
        (loop (fx+ i 1))))))

(let ((_ (solve 4)))
  (print _) (assert (= _ 134043)))
