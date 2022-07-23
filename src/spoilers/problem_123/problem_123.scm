(import (euler)
        (srfi 1))

(define (compute prime index)
  (let ((mod (* prime prime)))
    (modulo (+ (expt-mod (- prime 1) index mod)
               (expt-mod (+ prime 1) index mod))
            mod)))

(define (solve n)
  (let ((lst (primes (expt 10 6))))
    (call/cc
      (lambda (return)
        (for-each
          (lambda (prime index)
            (when (> (compute prime index) n)
              (return index)))
          lst (iota (length lst) 1))))))

(print (solve (expt 10 10)))
