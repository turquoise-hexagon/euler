(import
  (euler))

(define (binomial n k)
  (quotient (factorial n) (* (factorial k) (factorial (- n k)))))

(define (solve n)
  (let* ((n (+ n 1)) (l (quotient n 4)))
    (let loop ((i 0) (acc 0))
      (if (> i l)
        acc
        (loop (+ i 1) (+ acc (binomial (- n i i) (+ i i))))))))

(let ((_ (solve 50)))
  (print _) (assert (= _ 16475640049)))
