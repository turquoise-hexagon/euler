(import
  (euler))

(define (solve n)
  (apply lcm (range 1 n)))

(print (solve 20))
