(import (euler))

(define (solve n)
  (let ((primes (primes n)))
    (let solve/1/h ((a primes) (acc 0) (maximum 0))
      (if (null? a)
          acc
          (let solve/2/h ((b a) (num 0) (cnt 0))
            (if (or (null? b) (> (+ num (car b)) n))
                (if (and (> cnt maximum) (member num primes))
                    (solve/1/h (cdr a) num cnt)
                    (solve/1/h (cdr a) acc maximum))
                (solve/2/h (cdr b) (+ num (car b)) (+ cnt 1))))))))

(print (solve 1000000))
