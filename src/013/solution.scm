(import
  (chicken io))

(define (import-input)
  (map string->number (read-lines)))

(define (solve input)
  (let* ((tmp (apply + input)) (len (inexact->exact (ceiling (log tmp 10)))))
    (quotient tmp (expt 10 (- len 10)))))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 5537376230)))
