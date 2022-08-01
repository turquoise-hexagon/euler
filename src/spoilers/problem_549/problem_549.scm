(import
  (euler))

(define (jump prime count factorial)
  (let loop ((prime prime) (count count) (factorial factorial))
    (if (= prime 0)
      factorial
      (let ((_ (+ count 1)))
        (loop (- prime 1) _ (* factorial _))))))

(define (s prime n)
  (let loop ((count 0) (factorial 1))
    (if (= (modulo factorial n) 0)
      count
      (loop (+ count prime) (jump prime count factorial)))))

(define (solve n)
  (let ((acc (make-vector (+ n 1) 0)))
    (for-each
      (lambda (prime)
        (let loop ((i 0) (power prime))
          (unless (> power n)
            (let ((value (if (> i 0)
                           (s prime power)
                           power)))
              (let subloop ((multiple power))
                (unless (> multiple n)
                  (vector-set! acc multiple
                    (max (vector-ref acc multiple) value))
                  (subloop (+ multiple power)))))
            (loop (+ i 1) (* power prime)))))
      (primes n))
    (foldl + 0 (vector->list acc))))

(print (solve 100000000))
