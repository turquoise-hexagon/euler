(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define (make-prime? n)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (p)
        (hash-table-set! acc p #t))
      (primes (fx+ n 1)))
    (define (prime? n)
      (hash-table-exists? acc n))
    prime?))

(define (solve n)
  (let ((prime? (make-prime? n)))
    (let ((cache (make-vector (fx+ n 1) #t)))
      (let loop ((a 1) (acc (fx/ (fx* n (fx+ n 1)) 2)))
        (if (fx> (fx* a a) n)
          acc
          (if (vector-ref cache a)
            (let subloop ((b (fx* a a)) (acc acc))
              (if (fx> b n)
                (loop (fx+ a 1) acc)
                (subloop (fx+ b a)
                  (if (vector-ref cache b)
                    (if (prime? (fx+ a (fx/ b a)))
                      acc
                      (begin
                        (vector-set! cache b #f)
                        (fx- acc b)))
                    acc))))
            (loop (fx+ a 1) acc)))))))

(let ((_ (solve #e1e8)))
  (print _) (assert (= _ 1739023853137)))
