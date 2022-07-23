(import
  (euler))

(define (count-successive-primes a b)
  (let loop ((n 0) (acc 0))
    (if (prime? (+ (* n n) (* a n) b))
      (loop (+ n 1) (+ acc 1))
      acc)))

(define (solve n)
  (apply *
    (extremum (power (range (- n) n) 2)
      (lambda (_)
        (apply count-successive-primes _))
      >)))

(print (solve 1000))
