(define (solve n e t m)
  (modulo (+ (* t (expt n e)) 1) m))

(let ((_ (solve 2 7830457 28433 #e1e10)))
  (print _) (assert (= _ 8739992577)))
