(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define-constant limit #e1e7)

(define (square-root n)
  (let loop ((i n))
    (let ((_ (fx/ (fx+ i (fx/ n i)) 2)))
      (if (fx< _ i)
        (loop _)
        i))))

(define (make-prime? n)
  (let ((acc (make-vector (fx+ n 1) #f)))
    (for-each
      (lambda (p)
        (vector-set! acc p #t))
      (primes n))
    (define (prime? n)
      (vector-ref acc n))
    prime?))

(define (make-valid? n)
  (let ((acc (make-vector (fx+ n 1))) (prime? (make-prime? n)))
    (define (valid? n)
      (let ((c (vector-ref acc n)))
        (if (boolean? c)
          c
          (let ((s (square-root n)))
            (let ((p (if (fx= (fx* s s) n)
                       (valid? s)
                       (prime? n))))
              (vector-set! acc n p)
              p)))))
    valid?))

(define (solve n m)
  (let ((valid? (make-valid? limit)))
    (let loop ((i 2) (cnt 0) (acc 1))
      (if (fx= cnt n)
        acc
        (if (valid? i)
          (loop (fx+ i 1) (fx+ cnt 1) (fxmod (fx* acc i) m))
          (loop (fx+ i 1) cnt acc))))))

(let ((_ (solve 500500 500500507)))
  (print _) (assert (= _ 35407281)))
