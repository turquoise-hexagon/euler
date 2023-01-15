(import
  (euler))

(define (count-successive-primes a b)
  (let loop ((n 0) (acc 0))
    (let ((_ (+ (* n n) (* a n) b)))
      (if (> _ 0)
        (if (prime? _)
          (loop (+ n 1) (+ acc 1))
          acc)
        acc))))

(define (solve n)
  (apply *
    (extremum (power (range (- n) n) 2)
      (lambda (_)
        (apply count-successive-primes _))
      >)))

(let ((_ (solve 1000)))
  (print _) (assert (= _ -59231)))
