(import
  (chicken string)
  (euler)
  (srfi 1))

(define (choose n k)
  (let ((_ (- n k)))
    (/ (factorial n)
       (* (factorial k)
          (factorial _)))))

#|
t => number of balls
p => number of picks
c => number of colors
|#
(define (solve t p c)
  (let ((_ (- t (/ t c))))
    (* c (- 1 (/ (choose _ p)
                 (choose t p))))))

(define (output n)
  (first (string-chop (->string (exact->inexact n)) 11)))

(let ((_ (output (solve 70 20 7))))
  (print _) (assert (string=? _ "6.818741802")))
