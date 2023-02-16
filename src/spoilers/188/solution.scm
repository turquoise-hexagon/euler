(import
  (euler))

(define (solve a b m)
  (let loop ((a a) (b b))
    (if (= b 1)
      a
      (modular-expt a (loop a (- b 1)) m))))

(let ((_ (solve 1777 1855 #e1e8)))
  (print _) (assert (= _ 95962097)))
