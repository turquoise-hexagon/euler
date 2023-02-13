(define-constant phi (/ (+ 1 (sqrt 5)) 2))
(define-constant log_phi_sqrt_5 (log (sqrt 5) phi))
(define-constant log_phi_10 (log 10 phi))

(define (solve n)
  (let loop ((i 0))
    (if (= (ceiling (/ (- i log_phi_sqrt_5) log_phi_10)) n)
      i
      (loop (+ i 1)))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 4782)))
