(import euler)

(define (palindrome-base? n base)
  (let ((lst (number->list n base)))
    (equal? lst (reverse lst))))

(define (main n)
  (do ((x 1 (add1 x))
       (acc 0 (if (and (palindrome-base? x 2)
                       (palindrome-base? x 10))
                  (+ acc x)
                  acc)))
    ((= x n) acc)))

(display (main 1000000))
(newline)
