(import
  (srfi 69))

(define (_solve n)
  (let* ((a (quotient n 2)) (b (- a 1)))
    (if (even? n)
      (+ (solve a)
         (solve b))
      (solve a))))

(define solve
  (let ((cache (make-hash-table)))
    (hash-table-set! cache 0 1)
    (hash-table-set! cache 1 1)
    (lambda (n)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let ((acc (_solve n)))
          (hash-table-set! cache n acc)
          acc)))))

(let ((_ (solve #e1e25)))
  (print _) (assert (= _ 178653872807)))
