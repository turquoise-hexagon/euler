(import
  (euler))

(define (count-successive-primes a b)
  (let loop ((n 0) (acc 0))
    (if (prime? (+ (* n n) (* a n) b))
      (loop (+ n 1) (+ acc 1))
      acc)))

(define (solve n)
  (let ((lst (combinations (range (- n) n) 2)))
    (let loop ((lst lst) (len 0) (acc 0))
      (if (null? lst)
        acc
        (apply
          (lambda (a b)
            (let ((tmp (count-successive-primes a b)))
              (if (> tmp len)
                (loop (cdr lst) tmp (* a b))
                (loop (cdr lst) len acc))))
          (car lst))))))

(print (solve 1000))
