(import
  (only (srfi 152) substring))

(define (sequence n)
  (list->string
    (let loop ((n n))
      (if (= n 1)
        '()
        (case (modulo n 3)
          ((0) (cons #\D (loop (quotient (+ (* 1 n) 0) 3))))
          ((1) (cons #\U (loop (quotient (+ (* 4 n) 2) 3))))
          ((2) (cons #\d (loop (quotient (- (* 2 n) 1) 3)))))))))

(define (match? n str)
  (let ((res (sequence n)))
    (string=? str
      (substring res 0
        (min
          (string-length res)
          (string-length str))))))

(define (solve start str)
  (let ((len (string-length str)))
    (let loop ((acc start) (increment 1) (index 1))
      (if (> index len)
        acc
        (let ((str (substring str 0 index)))
          (let subloop ((i acc))
            (if (match? i str)
              (loop i (* increment 3) (+ index 1))
              (subloop (+ i increment)))))))))

(let ((_ (solve #e1e15 "UDDDUdddDDUDDddDdDddDDUDDdUUDd")))
  (print _) (assert (= _ 1125977393124310)))
