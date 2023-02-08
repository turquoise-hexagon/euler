(define (a n)
  (let loop ((i 0) (acc 0))
    (if (> (+ (* 4 i) 3) n)
      acc
      (loop (+ i 1) (+ acc (* 100 (expt 500 i)))))))

(define (b n)
  (let loop ((i 1) (acc 0))
    (if (> (* 2 i) n)
      acc
      (loop (+ i 1) (+ acc (* 20 (expt 30 (- i 1))))))))

(define (solve n)
  (+ (a n)
     (b n)))

(let ((_ (solve 9)))
  (print _) (assert (= _ 608720)))
