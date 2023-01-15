(import
  (euler))

(define (choose a b)
  (/ (factorial a) (* (factorial b) (factorial (- a b)))))

(define (solve n)
  (choose (* 2 n) n))

(let ((_ (solve 20)))
  (print _) (assert (= _ 137846528820)))
