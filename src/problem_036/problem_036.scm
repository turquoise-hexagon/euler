(import
  (euler)
  (srfi 1))

(define (solve n)
  (apply +
    (filter
      (lambda (i)
        (and (palindrome? i 2)
             (palindrome? i 10)))
      (range 1 n))))

(print (solve 1000000))
