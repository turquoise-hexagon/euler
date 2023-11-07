(import
  (srfi 69))

(define-inline (next n)
  (let-values (((q r) (quotient&remainder n 4)))
    (case r
      ((1) (- (+ (* 2 (S (+ (* 2 q) 1))) (* 4 (S (* 2 q)))) (* 6 (S q)) (* 2 (S (- q 1))) 1))
      ((2) (- (+ (* 3 (S (+ (* 2 q) 1))) (* 3 (S (* 2 q)))) (* 6 (S q)) (* 2 (S (- q 1))) 1))
      ((0) (- (* 6 (S (* 2 q))) (* 5 (S q)) (* 3 (S (- q 1))) 1))
      ((3) (- (* 6 (S (+ (* 2 q) 1))) (* 8 (S q)) 1)))))

(define S
  (let ((cache (make-hash-table)))
    (hash-table-set! cache 0 0)
    (hash-table-set! cache 1 1)
    (hash-table-set! cache 2 2)
    (lambda (n)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let ((acc (next n)))
          (hash-table-set! cache n acc)
          acc)))))

(define (solve n m)
  (modulo (S n) m))

(let ((_ (solve (expt 3 37) #e1e9)))
  (print _) (assert (= _ 808981553)))
