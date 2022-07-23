(import (euler))

(define (solve n)
  (let solve/1/h ([a (primes n)] [acc 0])
    (if (null? a)
        acc
        (solve/1/h (cdr a) (+ acc (let solve/2/h ([b a] [acc 0])
                                    (if (or (null? b) (> (* (car a) (car b)) n))
                                        acc
                                        (solve/2/h (cdr b) (+ acc 1)))))))))

(print (solve (expt 10 8)))
