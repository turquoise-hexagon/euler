(import
  (euler))

(define (solve n)
  (let loop ((i 1))
    (if (> (/ (length (divisors (* i i))) 2) n)
      i
      (loop (+ i 1)))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 180180)))
