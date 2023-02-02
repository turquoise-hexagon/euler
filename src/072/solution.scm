(import
  (euler))

(define (make-phi n)
  (let ((acc (make-vector (+ n 1) 1)))
    (do ((i 0 (+ i 1))) ((> i n))
      (vector-set! acc i i))
    (for-each
      (lambda (p)
        (do ((m p (+ m p))) ((> m n))
          (vector-set! acc m (* (vector-ref acc m) (- 1 (/ 1 p))))))
      (primes n))
    (define (phi n)
      (vector-ref acc n))
    phi))

(define (solve n)
  (let ((phi (make-phi n)))
    (do ((i 2 (+ i 1))
         (acc 0 (+ acc (phi i))))
      ((> i n) acc))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 303963552391)))
