(import
  (euler)
  (srfi 152))

(define (f n)
  (* (+ (* 81   (expt n 4))
        (* 684  (expt n 3))
        (* 1401 (expt n 2))
        (* 434  (expt n 1))
        40)
     (expt 7 n) (+ n 1) 1/40))

(define (output value base nb-digits)
  (string->number (substring (number->string value base) 0 nb-digits)))

(let ((_ (output (f 142857) 7 10)))
  (print _) (assert (= _ 5226432553)))
