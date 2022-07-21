(import
  (euler))

(define (solve n)
  (let loop ((lst (primes n)) (acc 1))
    (let ((tmp (* acc (car lst))))
      (if (> tmp n)
        acc
        (loop (cdr lst) tmp)))))

(print (solve 1000000))
