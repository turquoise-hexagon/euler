(import
  (chicken fixnum))

(define (collatz n)
  (let loop ((n n) (acc 1))
    (if (fx= n 1)
      acc
      (loop
        (if (fxodd? n)
          (fx+ (fx* 3 n) 1)
          (fx/ n 2))
        (fx+ acc 1)))))

(define (solve n)
  (let loop ((i 1) (res 0) (acc 0))
    (if (fx> i n)
      acc
      (let ((tmp (collatz i)))
        (if (fx> tmp res)
          (loop (fx+ i 1) tmp i)
          (loop (fx+ i 1) res acc))))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 837799)))
