(import
  (euler))

(define (helper prime index)
  (let ((mod (* prime prime)))
    (modulo (+ (expt-mod (- prime 1) index mod)
               (expt-mod (+ prime 1) index mod))
            mod)))

(define (solve n)
  (let ((primes (primes 1000000)))
    (call/cc
      (lambda (_)
        (for-each
          (lambda (prime index)
            (when (> (helper prime index) n)
              (_ index)))
          primes (range 1 (length primes)))))))

(print (solve #e1e10))
