(define (solve n)
  (let loop ((i 3) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1)
        (+ acc (* 2 i (quotient (- i 1) 2)))))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 333082500)))
