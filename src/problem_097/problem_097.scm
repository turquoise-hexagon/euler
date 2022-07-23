(define (solve n e t m)
  (modulo (+ (* t (expt n e)) 1) m))

(print (solve 2 7830457 28433 (expt 10 10)))
