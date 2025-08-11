(import
  (euler))

(define (function n)
  (let loop ((i 1) (acc 1))
    (if (> i n)
      (floor acc)
      (loop (+ i 1) (* acc (expt (/ (* i 2) (+ n 1)) i))))))

(define (solve n)
  (let loop ((i 2) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1) (+ acc (function i))))))

(let ((_ (solve 15)))
  (print _) (assert (= _ 371048281)))
