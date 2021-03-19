(import (euler)
        (srfi 1))

(define (solve n)
  (let* ((low (expt 10 (- n 1))) (high (expt 10 n)) (lst (iota (- high low) low)))
    (apply max (fold
                 (lambda (a acc)
                   (append (fold
                             (lambda (b acc)
                               (if (palindrome? (* a b))
                                   (cons (* a b) acc)
                                   acc))
                             '() lst)
                           acc))
                 '() lst))))

(print (solve 3))
