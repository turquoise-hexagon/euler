(import
  (euler))

(define-constant limit 100)

(define (solve target)
  (let ((acc (make-vector (+ limit 1) 0)))
    (vector-set! acc 0 1)
    (for-each
      (lambda (n)
        (do ((i n (+ i 1))) ((> i limit))
          (vector-set! acc i (+ (vector-ref acc i) (vector-ref acc (- i n))))))
      (primes limit))
    (do ((i 0 (+ i 1)))
      ((> (vector-ref acc i) target) i))))

(let ((_ (solve 5000)))
  (print _) (= _ 71))
