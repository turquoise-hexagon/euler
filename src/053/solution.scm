(import
  (euler)
  (srfi 1))

(define (choose a b)
  (/ (factorial a) (* (factorial b) (factorial (- a b)))))

(define (solve n limit)
  (count
    (lambda (_)
      (> _ limit))
    (map
      (lambda (_)
        (apply choose _))
      (power (range 1 n) 2))))

(print (solve 100 1000000))
