(import (srfi 1))

(define (sieve n)
  (let ((sieve (make-vector n 0)))
    (do ((i 1 (+ i 1))) ((>= i n))
      (do ((j (+ i i) (+ j i))) ((>= j n))
        (vector-set! sieve j (+ i (vector-ref sieve j)))))
    sieve))

(define (solve n)
  (let ((sieve (sieve n)))
    (fold
      (lambda (a acc)
        (let ((b (vector-ref sieve a)))
          (if (and (> n b) (not (= a b))
                   (= (vector-ref sieve b) a))
              (+ acc b)
              acc)))
      0 (iota n))))

(print (solve 10000))
