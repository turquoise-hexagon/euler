(import
  (euler)
  (srfi 69)
  (srfi 1))

(define (squares n)
  (do ((i 1 (+ i 1)) (acc '() (cons (* i i) acc)))
    ((>= (* i i) n) (reverse acc))))

(define (solve n)
  (let ((acc (make-hash-table)))
    (let loop ((lst (squares n)))
      (if (null? (cddr lst))
        (apply + (filter palindrome? (hash-table-keys acc)))
        (let subloop ((tmp (cddr lst)) (sum (+ (car lst) (cadr lst))))
          (if (or (null? tmp) (> sum n))
            (loop (cdr lst))
            (begin
              (hash-table-set! acc sum #t)
              (subloop (cdr tmp) (+ sum (car tmp))))))))))

(print (solve 100000000))
