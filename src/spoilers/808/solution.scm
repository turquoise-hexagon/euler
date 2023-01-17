(import
  (euler))

(define (reverse-number n)
  (let loop ((n n) (acc 0))
    (if (= n 0)
      acc
      (loop (quotient n 10)
        (+ (* acc 10) (modulo n 10))))))

(define (solve n)
  (let loop ((i 1) (acc 0) (cnt 0))
    (if (= cnt n)
      acc
      (let* ((s (* i i)) (r (reverse-number s)))
        (if (= s r)
          (loop (+ i 2) acc cnt)
          (let ((_ (sqrt r)))
            (if (and (integer? _)
                     (prime? _)
                     (prime? i))
              (loop (+ i 2) (+ acc s) (+ cnt 1))
              (loop (+ i 2) acc cnt))))))))
   
(let ((_ (solve 50)))
  (print _) (assert (= _ 3807504276997394)))
