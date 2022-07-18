(import
  (euler))

(define (solve n)
  (let loop/1 ((lst/1 (primes n)) (cnt/1 0) (acc/1 0))
    (if (null? lst/1)
      acc/1
      (let loop/2 ((lst/2 lst/1) (cnt/2 0) (acc/2 0))
        (if (or (null? lst/2) (> (+ acc/2 (car lst/2)) n))
          (if (and (> cnt/2 cnt/1) (prime? acc/2))
            (loop/1 (cdr lst/1) cnt/2 acc/2)
            (loop/1 (cdr lst/1) cnt/1 acc/1))
          (loop/2 (cdr lst/2) (+ cnt/2 1) (+ acc/2 (car lst/2))))))))

(print (solve 1000000))
