(import
  (euler))

(define (solve n)
  (apply max (factors n)))

(let ((_ (solve 600851475143)))
  (print _) (assert (= _ 6857)))
