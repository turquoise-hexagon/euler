(import euler)

(define (main n)
  (let helper ((c 0) (acc 0))
    (let ((acc (if (prime? c)
                   (add1 acc)
                   acc)))
      (if (= acc n)
          c
          (helper (add1 c) acc)))))

(display (main 10001))
(newline)
