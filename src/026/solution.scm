(import
  (euler)
  (srfi 69))

(define (cycle n)
  (let ((mem (make-hash-table)))
    (let loop ((i (expt 10 (integer-log n))))
      (let ((i (modulo i n)))
        (if (hash-table-exists? mem i)
          (hash-table-size mem)
          (begin
            (hash-table-set! mem i #t)
            (loop (* i 10))))))))

(define (solve limit)
  (let loop ((i 2) (cur 0) (acc 0))
    (if (= i limit)
      acc
      (let ((tmp (cycle i)))
        (if (> tmp cur)
          (loop (+ i 1) tmp i)
          (loop (+ i 1) cur acc))))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 983)))
