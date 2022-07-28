(import
  (euler))

(define (solve n)
  (let loop ((i 1))
    (if (> (/ (length (divisors (* i i))) 2) n)
      i
      (loop (+ i 1)))))

(print (solve 1000))
