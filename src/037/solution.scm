(import
  (euler))

(define (number-length n)
  (inexact->exact (ceiling (log n 10))))

(define (valid? n)
  (let loop ((a n) (b n) (m (expt 10 (- (number-length n) 1))))
    (if (= a 0)
      #t
      (if (and (prime? a)
               (prime? b))
        (loop (quotient a 10) (modulo b m) (quotient m 10))
        #f))))

(define (solve)
  (let loop ((i 8) (cnt 0) (acc 0))
    (if (= cnt 11)
      acc
      (if (valid? i)
        (loop (+ i 1) (+ cnt 1) (+ acc i))
        (loop (+ i 1) cnt acc)))))

(let ((_ (solve)))
  (print _) (assert (= _ 748317)))
