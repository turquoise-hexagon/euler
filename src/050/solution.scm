(import
  (euler))

(define (make-prime? primes n)
  (let ((acc (make-vector (+ n 1) #f)))
    (for-each
      (lambda (i)
        (vector-set! acc i #t))
      primes)
    (lambda (n)
      (vector-ref acc n))))

(define (solve n)
  (let* ((lst (primes n)) (prime? (make-prime? lst n)))
    (let loop/1 ((lst/1 lst) (cnt/1 0) (acc/1 0))
      (if (null? lst/1)
        acc/1
        (let loop/2 ((lst/2 lst/1) (cnt/2 0) (acc/2 0))
          (if (or (null? lst/2) (> (+ acc/2 (car lst/2)) n))
            (if (and (> cnt/2 cnt/1) (prime? acc/2))
              (loop/1 (cdr lst/1) cnt/2 acc/2)
              (loop/1 (cdr lst/1) cnt/1 acc/1))
            (loop/2 (cdr lst/2) (+ cnt/2 1) (+ acc/2 (car lst/2)))))))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 997651)))
