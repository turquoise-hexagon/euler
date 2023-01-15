(import
  (euler)
  (srfi 1))

(define (solve n)
  (apply max
    (filter palindrome?
      (map
        (lambda (pair)
          (apply * pair))
        (combinations
          (range (expt 10 (- n 1))
                 (- (expt 10 n) 1))
          2)))))

(let ((_ (solve 3)))
  (print _) (assert (= _ 906609)))
