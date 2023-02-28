(import
  (chicken io))

(define (import-input)
  (apply + (map string->number (read-lines))))

(define (number-length n)
  (inexact->exact (ceiling (log n 10))))

(define (solve input)
  (quotient input (expt 10 (- (number-length input) 10))))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 5537376230)))
