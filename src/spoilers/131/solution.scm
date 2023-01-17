(import
  (euler))

(define (solve n)
  (let loop ((i 0) (acc 0))
    (let* ((tmp (- (expt (+ i 1) 3) (expt i 3)))
           (acc (if (prime? tmp)
                  (+ acc 1)
                  acc)))
      (if (> tmp n)
        acc
        (loop (+ i 1) acc)))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 173)))
