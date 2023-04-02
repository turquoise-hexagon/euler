(import
  (euler)
  (srfi 152))

(define (f n)
  (* (+ (* 81   (expt n 5))
        (* 765  (expt n 4))
        (* 2085 (expt n 3))
        (* 1835 (expt n 2))
        (* 474  (expt n 1))
        40)
     (expt 7 n) 1/40))

(define (output value base nb-digits)
  (string->number (substring (number->string value base) 0 nb-digits)))

(let ((_ (output (f 142857) 7 10)))
  (print _) (assert (= _ 5226432553)))
