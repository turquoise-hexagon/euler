(import
  (euler)
  (srfi 1))

(define (diagonals n)
  `(,(+ (* 4 n n) (* 4 n)  1)
    ,(+ (* 4 n n) (* 2 n)  1)
    ,(- (* 4 n n) (* 2 n) -1)
    ,(+ (* 4 n n) 1)))

(define (solve)
  (let loop ((i 1) (primes 0) (total 1))
    (let ((primes (+ primes (count prime? (diagonals i)))) (total (+ total 4)))
      (if (> 1/10 (/ primes total))
        (+ (* 2 i) 1)
        (loop (+ i 1) primes total)))))

(let ((_ (solve)))
  (print _) (assert (= _ 26241)))
