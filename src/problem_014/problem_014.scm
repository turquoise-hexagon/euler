(import
  (euler)
  (srfi 69))

(define _collatz
  (alist->hash-table '((1 . 1))))

(define (collatz n)
  (let loop ((i n) (acc 0))
    (if (hash-table-exists? _collatz i)
      (let ((tmp (+ (hash-table-ref _collatz i) acc)))
        (hash-table-set! _collatz n tmp)
        tmp)
      (loop
        (if (even? i)
          (quotient i 2)
          (+ (* 3 i) 1))
        (+ acc 1)))))

(define (solve n)
  (extremum (range 1 n) collatz >))

(print (solve 1000000))
