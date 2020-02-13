(import euler)

(define (main n)
  (do ((lst (sieve n) (cdr lst))
       (acc 0 (+ acc (do ((tmp lst (cdr tmp))
                          (acc 0 (add1 acc)))
                       ((or (null? tmp)
                            (> (* (car lst) (car tmp)) n))
                        acc)))))
    ((null? lst) acc)))

(display (main (expt 10 8)))
(newline)
