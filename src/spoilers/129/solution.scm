(define (a n)
  (if (= (gcd n 10) 1)
    (let loop ((i 1) (acc 1))
      (if (= i 0)
        acc
        (loop (modulo (+ (* i 10) 1) n) (+ acc 1))))
    0))

(define (solve n)
  (let loop ((i (+ n 1)))
    (if (> (a i) n)
      i
      (loop (+ i 2)))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 1000023)))
