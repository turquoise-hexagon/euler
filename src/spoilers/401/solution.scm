(define-inline (f n)
  (quotient (* n (+ n 1) (+ n n 1)) 6))

(define (solve n m)
  (let loop ((i 1) (acc 0))
    (if (> (* i i) n)
      (let ((t (- i 1)))
        (modulo (- acc (* t (f t))) m))
      (loop (+ i 1)
        (let ((t (quotient n i)))
          (modulo (+ acc (f t) (* i i t)) m))))))

(let ((_ (solve #e1e15 #e1e9)))
  (print _) (assert (= _ 281632621)))
