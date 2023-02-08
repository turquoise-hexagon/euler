(import
  (euler))

(define (solve l n)
  (let ((m (expt 10 n)))
    (do ((i 1 (+ i 1))
         (acc 0 (modulo (+ acc (modular-expt i i m)) m)))
      ((> i l) acc))))

(let ((_ (solve 1000 10)))
  (print _) (assert (= _ 9110846700)))
