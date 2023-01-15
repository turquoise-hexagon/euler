(import
  (euler))

(define (solve n)
  (apply max (factorize n)))

(let ((_ (solve 600851475143)))
  (print _) (assert (= _ 6857)))
