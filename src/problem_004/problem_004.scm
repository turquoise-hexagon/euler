(import
  (euler)
  (srfi 1))

(define (solve n)
  (apply max
    (filter palindrome?
      (map
        (lambda (pair)
          (apply * pair))
        (powerset
          (range (expt 10 (- n 1))
                 (- (expt 10 n) 1))
          2)))))

(print (solve 3))
