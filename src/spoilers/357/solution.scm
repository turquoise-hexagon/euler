(import
  (euler)
  (srfi 69))

(define (solve n)
  (define _cache
    (let ((acc (make-hash-table)))
      (for-each
        (lambda (i)
          (hash-table-set! acc i #t))
        (primes (+ n 1)))
      acc))

  (define (_prime? n)
    (hash-table-exists? _cache n))

  (let ((sieve (make-vector (+ n 1) #t)))
    (do ((i 1 (+ i 1))) ((> (* i i) n))
      (when (vector-ref sieve i)
        (do ((j (* i i) (+ j i))) ((> j n))
          (when (vector-ref sieve j)
            (unless (_prime? (+ i (quotient j i)))
              (vector-set! sieve j #f))))))
    (do ((i 1 (+ i 1))
         (a 0 (if (vector-ref sieve i)
                (+ a i)
                a)))
      ((> i n) a))))

(let ((_ (solve #e1e8)))
  (print _) (assert (= _ 1739023853137)))
