(import
  (euler))

(define (solve n)
  (extremum (range 2 1000) (lambda (_) (discrete-log 10 1 _)) >))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 983)))
