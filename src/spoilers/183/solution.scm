(define-constant e 2.7182818284)

(define (exact n)
  (inexact->exact (round n)))

(define (d n)
  (let ((i (exact (/ n e))))
    (let loop ((i (quotient i (gcd n i)))) ;; simplify
      (cond
        ((= (modulo i 2) 0) (loop (quotient i 2)))
        ((= (modulo i 5) 0) (loop (quotient i 5)))
        ((= i 1)
         (- n))
        (else
         n)))))

(define (solve n)
  (let loop ((i 5) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1) (+ acc (d i))))))

(let ((_ (solve #e1e4)))
  (print _) (assert (= _ 48861552)))
