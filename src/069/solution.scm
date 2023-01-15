(import
  (euler))

(define (solve n)
  (let loop ((lst (primes n)) (acc 1))
    (let ((tmp (* acc (car lst))))
      (if (> tmp n)
        acc
        (loop (cdr lst) tmp)))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= 510510)))
