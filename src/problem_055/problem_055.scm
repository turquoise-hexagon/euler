(import (euler)
        (srfi 1))

(define (reverse-number n)
  (foldr
    (lambda (a acc)
      (+ a (* acc 10)))
    0 (number->list n)))

(define (lychrel? n)
  (let lychrel?/h ((n n) (i 0))
    (if (= i 50)
        #t
        (let ((t (+ n (reverse-number n))))
          (if (palindrome? t)
              #f
              (lychrel?/h t (+ i 1)))))))

(define (solve n)
  (count lychrel? (iota n)))

(print (solve 10000))
