(import
  (euler))

(define (solve n)
  (* (fibonacci (+ n n))
     (fibonacci (+ n n 1))))

(let ((_ (solve 15)))
  (print _) (assert (= _ 1120149658760)))
