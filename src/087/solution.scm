(import
  (euler))

(define (make-generate n)
  (let-values (((root _) (exact-integer-sqrt n)))
    (let ((primes (primes root)) (limit n))
      (define (generate exponent)
        (let loop ((lst primes) (acc '()))
          (if (null? lst)
            acc
            (let ((_ (expt (car lst) exponent)))
              (if (> _ limit)
                acc
                (loop (cdr lst) (cons _ acc)))))))
      generate)))

(define (solve n)
  (let ((generate (make-generate n)) (mem (make-vector (+ n 1) 0)))
    (for-each
      (lambda (lst)
        (let ((_ (apply + lst)))
          (unless (> _ n)
            (vector-set! mem _ 1))))
      (product
        (generate 2)
        (generate 3)
        (generate 4)))
    (let loop ((i 0) (acc 0))
      (if (> i n)
        acc
        (loop (+ i 1) (+ acc (vector-ref mem i)))))))

(let ((_ (solve #e5e7)))
  (print _) (assert (= _ 1097343)))
