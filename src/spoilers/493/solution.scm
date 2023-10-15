(import
  (chicken flonum)
  (chicken format)
  (chicken string)
  (euler))

#|
t => number of balls
p => number of picks
c => number of colors
|#
(define (solve t p c)
  (let ((_ (- t (/ t c))))
    (* c (- 1 (/ (binomial _ p)
                 (binomial t p))))))

(define (output n)
  (flonum-print-precision 11) (format "~a" (exact->inexact n)))

(let ((_ (output (solve 70 20 7))))
  (print _) (assert (string=? _ "6.818741802")))
