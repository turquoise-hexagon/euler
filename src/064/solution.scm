(define (check? i)
  (let ((root (inexact->exact (floor (sqrt i)))))
    (if (= (* root root) i)
      #f
      (let loop ((p 0) (d 1) (n 0) (a root))
        (let* ((n (- (* d a) n))
               (d (quotient (- i (* n n)) d))
               (a (quotient (+ root n) d))
               (p (+ p 1)))
          (if (not (= a (* 2 root)))
            (loop p d n a)
            (odd? p)))))))

(define (solve n)
  (let loop ((i 1) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1)
        (if (check? i)
          (+ acc 1)
          acc)))))

(print (solve 10000))
