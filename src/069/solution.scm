(import
  (euler))

(define (solve n)
  (let loop ((i 1) (acc 1))
    (if (prime? i)
      (let ((_ (* acc i)))
        (if (> _ n)
          acc
          (loop (+ i 1) _)))
      (loop (+ i 1) acc))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 510510)))
