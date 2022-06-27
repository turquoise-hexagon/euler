(define (solve n)
  (let loop ((a 0) (b 1) (acc 0))
    (if (> a n)
      acc
      (loop b (+ a b)
        (if (even? a)
          (+ acc a)
          acc)))))

(print (solve 4000000))
