(import
  (chicken fixnum))

(define (solve lim)
  (let loop ((i 3) (acc 0))
    (let ((cnt (fx* 4 (fx- i 1))))
      (if (fx> cnt lim)
        acc
        (let subloop ((cnt cnt) (j (fx- i 2)) (acc (fx+ acc 1)))
          (if (fx< j 3)
            (loop (fx+ i 1) acc)
            (let ((cnt (fx+ cnt (fx* 4 (fx- j 1)))))
              (if (fx> cnt lim)
                (loop (fx+ i 1) acc)
                (subloop cnt (fx- j 2) (fx+ acc 1))))))))))

(let ((_ (solve 1000000)))
  (print _) (assert (= _ 1572729)))
