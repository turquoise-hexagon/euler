(define (solve n)
  (let loop ((a 0) (b 1) (acc 0))
    (if (> a n)
      acc
      (loop b (+ a b)
        (if (even? a)
          (+ acc a)
          acc)))))

(let ((_ (solve #e4e6)))
  (print _) (assert (= _ 4613732)))
