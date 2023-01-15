(import
  (euler)
  (srfi 69))

(define (make-collatz)
  (let ((mem (make-hash-table)))
    (hash-table-set! mem 1 1) ;; init cache
    (lambda (n)
      (let loop ((i n) (acc 0))
        (if (hash-table-exists? mem i)
          (let ((_ (+ acc (hash-table-ref mem i))))
            (hash-table-set! mem n _)
            _)
          (loop
            (if (even? i) 
              (quotient i 2)
              (+ (* 3 i) 1))
            (+ acc 1)))))))

(define (solve n)
  (let ((collatz (make-collatz)))
    (extremum (range 1 n) collatz >)))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 837799)))
