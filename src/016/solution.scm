(import
  (euler))

(define (solve n)
  (digitsum n))

(let ((_ (solve (expt 2 1000))))
  (print _) (assert (= _ 1366)))
