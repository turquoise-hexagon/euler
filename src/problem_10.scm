(import euler)

(define (main n)
  (do ((lst (sieve n) (cdr lst))
       (acc 0 (+ acc (car lst))))
    ((null? lst) acc)))

(display (main 2000000))
(newline)
