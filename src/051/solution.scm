(import
  (chicken fixnum)
  (euler))

(define-constant limit #e1e6)

(define (reverse-number n)
  (let loop ((n n) (acc 0))
    (if (fx= n 0)
      acc
      (loop (fx/ n 10) (fx+ (fxmod n 10) (fx* acc 10))))))

(define (edit-number n d r)
  (let loop ((n n) (acc 0))
    (if (fx= n 0)
      (reverse-number acc)
      (loop (fx/ n 10)
        (let ((i (fxmod n 10)))
          (fx+ (if (fx= i d) r i) (fx* acc 10)))))))

(define (digits-count n)
  (let ((acc (make-vector 10 0)))
    (let loop ((n n))
      (if (fx= n 0)
        acc
        (begin
          (let ((i (fxmod n 10)))
            (vector-set! acc i (fx+ (vector-ref acc i) 1)))
          (loop (fx/ n 10)))))))

(define (make-prime? primes limit)
  (let ((acc (make-vector (fx+ limit 1) #f)))
    (for-each
      (lambda (i)
        (vector-set! acc i #t))
      primes)
    (define (prime? n)
      (vector-ref acc n))
    prime?))

(define (make-valid? primes limit)
  (let ((prime? (make-prime? primes limit)))
    (define (valid? n l)
      (let ((mem (digits-count n)))
        (let loop ((d 0))
          (if (fx= d 10)
            #f
            (if (fx> (vector-ref mem d) 1)
              (let subloop ((r 0) (acc 0))
                (if (fx= acc l)
                  #t
                  (if (fx= r 10)
                    (loop (fx+ d 1))
                    (subloop (fx+ r 1)
                      (let ((i (edit-number n d r)))
                        (if (and (fx>= i n) (prime? i))
                          (fx+ acc 1)
                          acc))))))
              (loop (fx+ d 1)))))))
    valid?))

(define (solve l)
  (let* ((primes (primes limit)) (valid? (make-valid? primes limit)))
    (let loop ((lst primes))
      (if (valid? (car lst) l)
        (car lst)
        (loop (cdr lst))))))

(let ((_ (solve 8)))
  (print _) (assert (= _ 121313)))
