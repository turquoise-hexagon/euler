(import
  (euler))

(define (solve n)
  (let loop ((i 1) (index 1) (counted 0) (acc 1))
    (if (> index n)
      acc
      (let* ((lst (number->list i)) (len (length lst)) (total (+ counted len)))
        (if (>= total index)
          (loop (+ i 1) (* index 10) total (* acc (list-ref lst (- len (- total index) 1))))
          (loop (+ i 1) index total acc))))))

(print (solve 1000000))
