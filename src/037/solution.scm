(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define (order n)
  (let loop ((i 1))
    (let ((_ (fx* i 10)))
      (if (fx> _ n)
        i
        (loop _)))))

(define (make-valid? primes)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (_)
        (hash-table-set! acc _ #t))
      primes)
    (define (valid? n)
      (let loop ((a n) (b n) (d (order n)))
        (if (fx= a 0)
          #t
          (if (and (hash-table-exists? acc a)
                   (hash-table-exists? acc b))
            (loop (fx/ a 10) (fxmod b d) (fx/ d 10))
            #f))))
    valid?))

(define (solve)
  (let* ((primes (primes #e1e6)) (valid? (make-valid? primes)))
    (let loop ((lst (cddddr primes)) (cnt 0) (acc 0))
      (if (fx= cnt 11)
        acc
        (let ((i (car lst)))
          (if (valid? i)
            (loop (cdr lst) (fx+ cnt 1) (fx+ acc i))
            (loop (cdr lst) cnt acc)))))))

(let ((_ (solve)))
  (print _) (assert (= _ 748317)))
