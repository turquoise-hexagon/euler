(import
  (euler))

(define (solve n)
  (apply max
    (map
      (lambda (pairs)
        (digitsum (apply expt pairs)))
      (combinations (range 1 n) 2))))

(print (solve 100))
