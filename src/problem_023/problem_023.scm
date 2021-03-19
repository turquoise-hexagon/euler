(import (srfi 1))

(define (divisors n)
  (let ((sieve (make-vector n 0)))
    (do ((i 1 (+ i 1))) ((>= i n))
      (do ((j (+ i i) (+ j i))) ((>= j n))
        (vector-set! sieve j (+ i (vector-ref sieve j)))))
    sieve))

(define (abundants n)
  (let ((lst (vector->list (divisors n))))
    (fold
      (lambda (a b acc)
        (if (> a b)
            (cons b acc)
            acc))
      '() lst (iota (length lst)))))

(define (solve n)
  (let ((array (list->vector (iota n))) (lst (abundants n)))
    (for-each
      (lambda (a)
        (for-each
          (lambda (b)
            (when (< (+ a b) n) (vector-set! array (+ a b) 0)))
          lst))
      lst)
    (apply + (vector->list array))))
  
(print (solve 28123))
