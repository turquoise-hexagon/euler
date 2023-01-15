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
      (combinations (range n 1) 2))))

(let ((_ (solve 100 #e1e6)))
  (print _) (assert (= _ 4075)))
