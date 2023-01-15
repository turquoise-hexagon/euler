(import
  (euler))

(define (solve n)
  (apply max
    (map
      (lambda (pairs)
        (digitsum (apply expt pairs)))
      (power (range 1 n) 2))))

(let ((_ (solve 100)))
  (print _) (assert (= _ 972)))
