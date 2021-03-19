(define (solve n)
  (let solve/h ((a 0) (b 1) (acc 0))
    (if (> a n)
        acc
        (solve/h b (+ a b) (if (even? a)
                              (+ acc a)
                              acc)))))

(print (solve 4000000))
