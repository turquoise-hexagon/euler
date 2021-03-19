(import (euler)
        (srfi 1))

(define digit-factorials
  (map factorial (iota 10)))

(define (factorial-digitsum n)
  (apply + (map (cut list-ref digit-factorials <>) (number->list n))))

(define (cycle n)
  (let cycle/h ((n n) (acc '()))
    (if (member n acc)
        acc
        (cycle/h (factorial-digitsum n) (cons n acc)))))

(define (solve n)
  (count
    (lambda (i)
      (= (length (cycle i)) 60))
    (iota n)))

(print (solve 1000000))
