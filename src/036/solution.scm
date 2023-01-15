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

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 872187)))
