(import euler
        (srfi 1))

(define facts
  (map fact (iota 10)))

(define (s n)
  (apply + (map
             (lambda (x)
               (list-ref facts x))
             (number->list n))))

(define (sf n)
  (digitsum (s n)))

(define (g n)
  (do ((x 1 (add1 x)))
    ((= (sf x) n) x)))

(define (sg n)
  (digitsum (g n)))

(define (main n)
  (do ((x 1 (add1 x))
       (acc 0 (+ (sg x) acc)))
    ((> x n) acc)))

(display (main 20))
(newline)
