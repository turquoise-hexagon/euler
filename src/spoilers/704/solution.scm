(define (exact n)
  (inexact->exact (floor n)))

(define (hamming-weight n)
  (let loop ((n n) (acc 0))
    (if (= n 0)
      acc
      (loop (quotient n 2)
        (if (odd? n)
          (+ acc 1)
          acc)))))

(define (f n)
  (let ((l (exact (log n 2))))
    (- (* (+ n 1) l) (* (- (expt 2 l) 1) 2))))

(define (g n)
  (- n (hamming-weight n)))

(define (solve n)
  (let ((i (+ n 1)))
    (- (f i) (g i))))

(let ((_ (solve #e1e16)))
  (print _) (assert (= _ 501985601490518144)))
