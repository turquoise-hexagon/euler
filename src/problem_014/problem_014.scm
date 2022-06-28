(import
  (srfi 69))

(define _collatz
  (alist->hash-table '((1 . 1))))

(define (collatz n)
  (let loop ((i n) (acc 0))
    (if (hash-table-exists? _collatz i)
      (let ((tmp (hash-table-ref _collatz i)))
        (hash-table-set! _collatz n (+ tmp acc))
        (+ tmp acc))
      (loop
        (if (even? i)
         (/ i 2)
         (+ (* 3 i) 1))
        (+ acc 1)))))

(define (solve n)
  (let loop ((i 1) (len 0) (acc 0))
    (if (> i n)
      acc
      (let ((tmp (collatz i)))
        (if (> tmp len)
          (loop (+ i 1) tmp i)
          (loop (+ i 1) len acc))))))

(print (solve 1000000))
