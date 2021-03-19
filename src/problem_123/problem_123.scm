(import (euler)
        (srfi 1))

(define (compute prime index)
  (modulo (+ (expt (- prime 1) index)
             (expt (+ prime 1) index))
          (* prime prime)))

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
