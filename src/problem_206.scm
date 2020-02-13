(import euler)

(define digits
  (reverse (list 1 2 3 4 5 6 7 8 9 0)))

(define (match? n)
  (let helper ((x n) (lst digits))
    (cond ((zero? x)
           #t)
          ((= (remainder x 10) (car lst))
           (helper (quotient x 100) (cdr lst)))
          (else
            #f))))

(define (main)
  (do ((x (inexact->exact (round (sqrt 1020304050607080900))) (+ x 10)))
    ((match? (* x x)) x)))

(display (main))
(newline)
