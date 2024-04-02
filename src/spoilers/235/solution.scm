(import
  (chicken flonum)
  (chicken format))

(define-constant limit 1/10000000000000)

(define (s n r)
  (let loop ((i 1) (acc 0) (pow 1.0))
    (if (> i n)
      acc
      (loop (+ i 1) (+ acc (* (- 900 (* 3 i)) pow)) (fp* pow r)))))

(define (output n)
  (flonum-print-precision 13)
  (format "~a" n))

(define (solve iterations target)
  (let loop ((l 0.0) (h 2.0))
    (if (< (- h l) limit)
      (output l)
      (let ((m (/ (+ h l) 2.0)))
        (if (> (s iterations m) target)
          (loop m h)
          (loop l m))))))

(let ((_ (solve 5000 -600000000000)))
  (print _) (assert (string=? _ "1.002322108633")))
