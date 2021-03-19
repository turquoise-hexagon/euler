(import (srfi 1))

(define (collatz n)
  (let collatz/h ((n n) (acc (list)))
    (let ((acc (cons n acc)))
      (if (= n 1)
          acc
          (collatz/h (if (even? n) (quotient n 2) (+ (* 3 n) 1)) acc)))))

(define (solve n)
  (cdr (fold
         (lambda (a acc)
           (let ((tmp (length (collatz a))))
             (if (> tmp (car acc))
                 (cons tmp a)
                 acc)))
         '(0 . 0) (iota n 1))))

(print (solve 1000000))
