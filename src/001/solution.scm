(define (solve limit)
  (define (_solve n)
    (let ((_ (quotient (- limit 1) n)))
      (quotient (* n _ (+ _ 1)) 2)))
  (- (+ (_solve 3)
        (_solve 5))
     (_solve 15)))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 233168)))