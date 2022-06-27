(define (solve n)
  (let loop ((i 1) (acc 0))
    (if (>= i n)
      acc
      (loop (+ i 1)
        (if (or (= (modulo i 3) 0)
                (= (modulo i 5) 0))
          (+ acc i)
          acc)))))

(print (solve 1000))
