(import
  (euler)
  (srfi 1))

(define (resilience n)
  (/ (totient n) (- n 1)))

(define (jump n)
  (let loop ((lst (primes 100)) (acc 1))
    (let ((tmp (* acc (car lst))))
      (if (< (resilience tmp) n)
        acc
        (loop (cdr lst) tmp)))))

(define (solve n)
  (let ((prod (jump n)))
    (let loop ((i 1))
      (let ((tmp (* prod i)))
        (if (< (resilience tmp) n)
          tmp
          (loop (+ i 1)))))))

(let ((_ (solve 15499/94744)))
  (print _) (assert (= _ 892371480)))
