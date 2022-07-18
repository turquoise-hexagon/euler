(import
  (euler))

(define limit 1000000)

(define (solve n)
  (foldl
    (lambda (acc i)
      (foldl
        (lambda (acc j)
          (if (> (/ (factorial i) (factorial j) (factorial (- i j))) limit)
            (+ acc 1)
            acc))
        acc (range 1 i)))
    0 (range 1 n)))

(print (solve 100))
