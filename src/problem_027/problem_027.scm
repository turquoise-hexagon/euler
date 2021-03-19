(import (euler))

(define (count-successive-primes a b)
  (let count-successive-primes/h ((n 0) (acc 0))
    (if (prime? (+ (* n n) (* a n) b))
        (count-successive-primes/h (+ n 1) (+ acc 1))
        acc)))

(define (solve n)
  (let solve/1/h ((a (- n)) (max/1 0) (acc/1 0))
    (if (> a n)
        acc/1
        (let solve/2/h ((b (- n)) (max/2 0) (acc/2 0))
          (if (> b n)
              (if (> max/2 max/1)
                  (solve/1/h (+ a 1) max/2 acc/2)
                  (solve/1/h (+ a 1) max/1 acc/1))
              (let ((tmp (count-successive-primes a b)))
                (if (> tmp max/2)
                    (solve/2/h (+ b 1) tmp (* a b))
                    (solve/2/h (+ b 1) max/2 acc/2))))))))

(print (solve 1000))
