(import euler
        (srfi 1))

(define facts
  (map factorial (iota 10)))

(define (sum-facts n)
  (apply +
         (map
           (lambda (x)
             (list-ref facts x))
           (number->list n))))

(define (main n)
  (do ((x 10 (add1 x))
       (acc 0 (if (= x (sum-facts x))
                  (+ acc x)
                  acc)))
    ((= x n) acc)))

(display (main 1000000))
(newline)
