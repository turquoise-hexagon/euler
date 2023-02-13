(import
  (chicken fixnum)
  (euler))

(define-constant limit #e1e6)

(define (order n)
  (let loop ((acc 1))
    (let ((_ (fx* acc 10)))
      (if (fx> _ n)
        acc
        (loop _)))))

(define (make-valid? primes limit)
  (let ((acc (make-vector (fx+ limit 1) #f)))
    (for-each
      (lambda (i)
        (vector-set! acc i #t))
      primes)
    (define (valid? n)
      (let loop ((a n) (b n) (c (order n)))
        (if (fx= a 0)
          #t
          (if (and (vector-ref acc a)
                   (vector-ref acc b))
            (loop (fx/ a 10) (fxmod b c) (fx/ c 10))
            #f))))
    valid?))

(define (solve)
  (let* ((primes (primes limit)) (valid? (make-valid? primes limit)))
    (let loop ((lst (list-tail primes 4)) (cnt 0) (acc 0))
      (if (fx= cnt 11)
        acc
        (let ((i (car lst)))
          (if (valid? i)
            (loop (cdr lst) (fx+ cnt 1) (fx+ acc i))
            (loop (cdr lst) cnt acc)))))))

(let ((_ (solve)))
  (print _) (assert (= _ 748317)))
