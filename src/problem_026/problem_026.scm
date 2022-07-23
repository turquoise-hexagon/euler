(import
  (euler))

(define (solve n)
  (extremum (range 1 1000) (lambda (_) (discrete-log 10 1 _)) >))

(print (solve 1000))
