(import
  (euler))

(define (solve n)
  (let loop ((i 2) (acc 0))
    (if (> (+ i i) n)
      acc
      (loop (+ i 1) (+ acc (* (binomial n (+ i i)) (binomial (+ i i -1) (- i 2))))))))

(let ((_ (solve 12)))
  (print _) (assert (= _ 21384)))
