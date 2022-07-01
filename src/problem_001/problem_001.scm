(import
  (euler)
  (srfi 1))

(define (solve n)
  (apply +
    (filter
      (lambda (i)
        (or (= (modulo i 3) 0)
            (= (modulo i 5) 0)))
      (range 1 n))))

(print (solve 1000))
