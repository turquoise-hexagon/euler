(import
  (euler))

(define (helper proc lst)
  (let loop ((lst lst) (acc '()))
    (if (null? lst)
      acc
      (loop (cdr lst) (cons (proc lst) acc)))))

(define (solve number limit)
  (let loop ((lst (primes number)) (n 1))
    (if (> n limit)
      0
      (foldl + 1
        (helper
          (lambda (_)
            (loop _ (* (car _) n)))
          lst)))))

(print (solve 100 1000000000))
