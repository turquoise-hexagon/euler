(import
  (euler))

(define (solve n)
  (apply lcm (range 1 n)))

(let ((_ (solve 20)))
  (print _) (assert (= _ 232792560)))
