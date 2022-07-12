(import
  (euler))

(define (solve n)
  (modulo (apply + (map (lambda (i) (expt i i)) (range 1 1000))) (expt 10 n)))

(print (solve 10))
