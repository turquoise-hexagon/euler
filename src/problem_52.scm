(define (digits n)
  (let ((array (make-vector 10 0)))
    (do ((x n (quotient x 10))) ((zero? x) array)
      (let ((tmp (remainder x 10)))
        (vector-set! array tmp (add1 (vector-ref array tmp)))))))

(define (permutation? x y)
  (equal? (digits x)
          (digits y)))

(define (main n)
  (let helper-1 ((x 1))
    (let helper-2 ((y 2))
      (if (= y n)
          x
          (if (permutation? x (* x y))
              (helper-2 (add1 y))
              (helper-1 (add1 x)))))))

(display (main 6))
(newline)
