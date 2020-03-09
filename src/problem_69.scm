(import euler)

(define (main n)
  (let helper ((lst (sieve n)) (acc 1))
    (let ((tmp (* acc (car lst))))
      (if (> tmp n)
          acc
          (helper (cdr lst) tmp)))))

(display (main 1000000))
(newline)
