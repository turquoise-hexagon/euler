(import
  (euler))

(define (choose a b)
  (/ (factorial a) (* (factorial b) (factorial (- a b)))))

(define (solve n)
  (choose (* 2 n) n))

(print (solve 20))
