(import
  (srfi 69))

(define (solve n)
  (let ((acc (make-hash-table)))
    (do ((a 2 (+ a 1))) ((> a n))
      (do ((b 2 (+ b 1))) ((> b n))
        (hash-table-set! acc (expt a b) #t)))
    (hash-table-size acc)))

(let ((_ (solve 100)))
  (print _) (assert (= _ 9183)))
