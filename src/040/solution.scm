(import
  (euler)
  (chicken fixnum))

(define (nth-digit n index)
  (let loop ((n n) (index (fx- (integer-log n) index)))
    (if (fx= index 0)
      (fxmod n 10)
      (loop (fx/ n 10) (fx- index 1)))))

(define (solve n)
  (let loop ((i 1) (index 1) (counted 0) (acc 1))
    (if (fx> index n)
      acc
      (let* ((len (integer-log i)) (total (fx+ counted len)))
        (if (fx< total index)
          (loop (fx+ i 1) index total acc)
          (loop (fx+ i 1) (fx* index 10) total (fx* acc (nth-digit i (fx- len (fx- total index))))))))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 210)))
