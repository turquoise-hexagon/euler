(import
  (euler))

(define (solve n)
  (let ((lst (range 1 n)))
    (- (expt (apply + lst) 2) (apply + (map (lambda (_) (expt _ 2)) lst)))))

(let ((_ (solve 100)))
  (print _) (assert (= _ 25164150)))
