(import
  (euler))

(define (solve n)
  (digitsum n))

(let ((_ (solve (factorial 100))))
  (print _) (assert (= _ 648)))
