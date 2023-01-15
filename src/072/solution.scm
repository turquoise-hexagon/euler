(import
  (euler))

(define (make-phi n)
  (let ((factors (make-vector (+ n 1) '())))
    (for-each
      (lambda (p)
        (do ((i p (+ i p))) ((> i n))
          (let ((_ (vector-ref factors i)))
            (unless (member p _)
              (vector-set! factors i (cons p _))))))
      (primes n))
    (lambda (n)
      (foldl * n
        (map
          (lambda (_)
            (- 1 (/ 1 _)))
          (vector-ref factors n))))))

(define (solve n)
  (let ((phi (make-phi n)))
    (foldl + 0 (map phi (range 2 n)))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 303963552391)))
