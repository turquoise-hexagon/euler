(import euler
        (srfi 1))

(define expts
  (map
    (lambda (x)
      (expt x 5))
    (iota 10)))

(define (sum-expts n)
  (apply +
         (map
           (lambda (x)
             (list-ref expts x))
           (number->list n))))

(define (main n)
  (do ((x 2 (add1 x))
       (acc 0 (if (= x (sum-expts x))
                  (+ acc x)
                  acc)))
    ((= x n) acc)))

(display (main 500000))
(newline)
