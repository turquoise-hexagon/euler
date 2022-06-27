(import
  (srfi 69))

(define _collatz (make-hash-table))

(define (helper! start lst)
  (foldl
    (lambda (cur i)
      (hash-table-set! _collatz i cur)
      (+ cur 1))
    start lst))

(define (collatz n)
  (let loop ((i n) (acc '()))
    (let ((acc (cons i acc)))
      (if (hash-table-exists? _collatz i)
        (let ((tmp (hash-table-ref _collatz i)))
          (helper! tmp acc)
          (+ tmp (length acc)))
        (if (= i 1)
          (begin
            (helper! 1 acc)
            (length acc))
          (loop
            (if (even? i)
              (quotient i 2)
              (+ (* 3 i) 1))
            acc))))))

(define (solve n)
  (let loop ((i 1) (len 0) (acc 0))
    (if (> i n)
      acc
      (let ((tmp (collatz i)))
        (if (> tmp len)
          (loop (+ i 1) tmp i)
          (loop (+ i 1) len acc))))))

(print (solve 1000000))
