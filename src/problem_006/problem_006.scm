(import
  (euler))

(define (solve n)
  (let ((lst (range 1 n)))
    (- (expt (apply + lst) 2) (apply + (map (lambda (_) (expt _ 2)) lst)))))

(print (solve 100))
