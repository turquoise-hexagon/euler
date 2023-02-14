(import
  (srfi 69))

(define collatz
  (let ((acc (make-hash-table)))
    (hash-table-set! acc 1 1)
    (lambda (n)
      (let loop ((n n))
        (if (hash-table-exists? acc n)
          (hash-table-ref acc n)
          (let ((_ (+ (loop (if (even? n)
                              (quotient n 2)
                              (+ (* 3 n) 1)))
                      1)))
            (hash-table-set! acc n _)
            _))))))

(define (solve n)
  (let loop ((i 1) (tmp 0) (acc 0))
    (if (> i n)
      acc
      (let ((_ (collatz i)))
        (if (> _ tmp)
          (loop (+ i 1) _ i)
          (loop (+ i 1) tmp acc))))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 837799)))
