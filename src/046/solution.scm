(import
  (chicken fixnum)
  (euler))

(define-constant limit #e1e4)

(define (double-squares limit)
  (let loop ((i 1) (acc '()))
    (let ((_ (fx* (fx* i i) 2)))
      (if (fx> _ limit)
        acc
        (loop (fx+ i 1) (cons _ acc))))))

(define (make-prime? primes limit)
  (let ((acc (make-vector (fx+ limit 1) #f)))
    (for-each
      (lambda (i)
        (vector-set! acc i #t))
      primes)
    (define (prime? n)
      (vector-ref acc n))
    prime?))

(define (make-valid? limit)
  (let* ((acc (make-vector (fx+ limit 1) #f)) (double-squares (double-squares limit)) (primes (primes limit)) (prime? (make-prime? primes limit)))
    (for-each
      (lambda (i)
        (for-each
          (lambda (j)
            (let ((_ (fx+ i j)))
              (unless (fx> _ limit)
                (vector-set! acc _ #t))))
          double-squares))
      primes)
    (define (valid? n)
      (and (not (vector-ref acc n)) (not (prime? n))))
    valid?))

(define (solve)
  (let ((valid? (make-valid? limit)))
    (let loop ((i 3))
      (if (valid? i)
        i
        (loop (fx+ i 2))))))

(let ((_ (solve)))
  (print _) (assert (= _ 5777)))
