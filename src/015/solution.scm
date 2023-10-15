(import
  (euler))

(define (solve n)
  (binomial (* 2 n) n))

(let ((_ (solve 20)))
  (print _) (assert (= _ 137846528820)))
