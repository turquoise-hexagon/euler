(import
  (chicken fixnum)
  (euler))

(define (make-number-solutions n)
  (let ((acc (make-vector (fx+ n 1) 1)))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m n)
            (let subloop ((i m) (tmp 0))
              (if (fx= (fxmod i p) 0)
                (subloop (fx/ i p) (fx+ tmp 1))
                (vector-set! acc m (fx* (vector-ref acc m) (fx+ (fx* tmp 2) 1)))))
            (loop (fx+ m p)))))
      (primes n))
    (let loop ((i 0))
      (unless (fx> i n)
        (vector-set! acc i (fx/ (fx- (vector-ref acc i) 1) 2))
        (loop (fx+ i 1))))
    (define (number-solutions n)
      (vector-ref acc n))
    number-solutions))

(define (solve n)
  (let ((number-solutions (make-number-solutions #e5e5)))
    (let loop ((i 0))
      (if (fx> (number-solutions i) n)
        i
        (loop (fx+ i 1))))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 180180)))
