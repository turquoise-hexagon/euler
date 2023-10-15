(import
  (euler)
  (srfi 1))

(define-constant squares '(1 4 9 16 25 36 49 64 81))

(define (add! v a b)
  (vector-set! v (+ (* a 10) b) #t)
  (vector-set! v (+ (* b 10) a) #t))

(define (valid? a b)
  (let ((acc (make-vector 100 #f)))
    (for-each
      (lambda (i)
        (for-each
          (lambda (j)
            (cond
              ((or (= i 6) (= i 9))
               (add! acc 6 j)
               (add! acc 9 j))
              ((or (= j 6) (= j 9))
               (add! acc 6 i)
               (add! acc 9 i))
              (else
               (add! acc i j))))
          b))
      a)
    (every
      (lambda (i)
        (vector-ref acc i))
      squares)))

(define (solve)
  (count
    (lambda (i)
      (apply valid? i))
    (combinations (combinations (range 0 9) 6) 2)))

(let ((_ (solve)))
  (print _) (assert (= _ 1217)))
