(import
  (euler))

(define (solve n)
  (let loop ((a 1) (b 2))
    (if (> (length (divisors a)) n)
      a
      (loop (+ a b) (+ b 1)))))

(print (solve 500))
