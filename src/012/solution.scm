(import
  (euler))

(define (number-divisors n)
  (apply *
    (map
      (lambda (_)
        (+ (car _) 1))
      (run-length (factors n)))))

(define (solve n)
  (let loop ((i 0) (acc 0))
    (if (> (number-divisors acc) n)
      acc
      (loop (+ i 1) (+ acc i)))))

(let ((_ (solve 500)))
  (print _) (assert (= _ 76576500)))
