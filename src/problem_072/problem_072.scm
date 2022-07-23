(import
  (euler))

(define (factors n)
  (let ((acc (make-vector (+ n 1) '())))
    (for-each
      (lambda (p)
        (do ((i p (+ i p))) ((> i n))
          (let ((_ (vector-ref acc i)))
            (unless (member p _)
              (vector-set! acc i (cons p _))))))
      (primes n))
    acc))

(define (phi factors n)
  (apply *
    (cons n
      (map
        (lambda (_)
          (- 1 (/ 1 _)))
        (vector-ref factors n)))))

(define (solve n)
  (let ((factors (factors n)))
    (foldl + 0
      (map
        (lambda (_)
          (phi factors _))
        (range 2 n)))))

(print (solve 1000000))
