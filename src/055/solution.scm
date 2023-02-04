(define (reverse-number n)
  (let loop ((n n) (acc 0))
    (if (= n 0)
      acc
      (loop (quotient n 10) (+ (* acc 10) (modulo n 10))))))

(define (valid? n)
  (let loop ((n (+ n (reverse-number n))) (acc 1))
    (if (> acc 50)
      #t
      (let ((r (reverse-number n)))
        (if (= n r)
          #f
          (loop (+ n r) (+ acc 1)))))))

(define (solve n)
  (let loop ((i 0) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1)
        (if (valid? i)
          (+ acc 1)
          acc)))))

(let ((_ (solve #e1e4)))
  (print _) (assert (= _ 249)))
