(define (collatz n)
  (do ((x n (if (odd? x)
                (add1 (* 3 x))
                (quotient x 2)))
       (acc 1 (add1 acc)))
    ((= x 1) acc)))

(define (main n)
  (let helper ((x 1) (acc 0) (var 0))
    (if (= x n)
        acc
        (let* ((tmp (collatz x))
               (val (> tmp var)))
          (helper (add1 x)
                  (if val x acc)
                  (if val tmp var))))))

(display (main 1000000))
(newline)
