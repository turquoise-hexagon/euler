(import euler
        (srfi 1))

(define facts
  (map fact (iota 10)))

(define (sum-facts n)
  (apply +
         (map
           (lambda (n)
             (list-ref facts n))
           (number->list n))))

(define (find-chain n)
  (do ((x n (sum-facts x))
       (acc (list) (cons x acc)))
    ((member x acc) acc)))

(define (main n)
  (do ((x 0 (add1 x))
       (acc 0 (if (= (length (find-chain x)) 60)
                  (add1 acc)
                  acc)))
    ((= x n) acc)))

(display (main 1000000))
(newline)
