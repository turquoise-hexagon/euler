(import
  (euler))

(define (solve n)
  (let loop ((a (primes n)) (acc 0))
    (if (null? a)
      acc
      (loop (cdr a)
        (let subloop ((b a) (acc acc))
          (if (or (null? b) (> (* (car a) (car b)) n))
            acc
            (subloop (cdr b) (+ acc 1))))))))

(print (solve (expt 10 8)))
