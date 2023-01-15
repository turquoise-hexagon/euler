(import
  (euler))

(define (solve n)
  (modulo (apply + (map (lambda (i) (expt i i)) (range 1 1000))) (expt 10 n)))

(let ((_ (solve 10)))
  (print _) (assert (= _ 9110846700)))
