(import
  (euler)
  (chicken io))

(define (import-input)
  (apply + (map string->number (read-lines))))

(define (solve input)
  (quotient input (expt 10 (- (+ (integer-log input) 1) 10))))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 5537376230)))
