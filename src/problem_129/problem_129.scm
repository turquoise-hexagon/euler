(define (a n)
  (if (= (gcd n 10) 1)
      (let a/h ((i 1) (acc 1))
        (if (= i 0)
            acc
            (a/h (modulo (+ (* i 10) 1) n) (+ acc 1))))
      0))

(define (main n)
  (let main/h ((i (+ n 1)))
    (if (> (a i) n)
        i
        (main/h (+ i 2)))))

(print (main 1000000))
