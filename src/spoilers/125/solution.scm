(import
  (euler)
  (srfi 69))

(define (squares n)
  (let loop ((i 1))
    (let ((_ (* i i)))
      (if (> _ n)
        '()
        (cons _ (loop (+ i 1)))))))

(define (solve n)
  (let ((acc (make-hash-table)))
    (let loop ((a (squares n)))
      (unless (null? (cddr a))
        (let loop ((b (cddr a)) (sum (+ (car a) (cadr a))))
          (unless (or (null? b) (> sum n))
            (when (palindrome? sum) ;; testing first is faster
              (hash-table-set! acc sum #t))
            (loop (cdr b) (+ sum (car b)))))
        (loop (cdr a))))
    (apply + (hash-table-keys acc))))

(let ((_ (solve #e1e8)))
  (print _) (assert (= _ 2906969179)))
