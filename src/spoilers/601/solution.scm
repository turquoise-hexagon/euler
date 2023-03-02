(define (p s n)
  (let loop ((i 1) (acc 1))
    (if (> i s)
      (- (quotient (- n 2) acc)
         (quotient (- n 2) (lcm acc (+ s 1))))
      (loop (+ i 1) (lcm acc i)))))

(define (solve n)
  (let loop ((i 1) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1) (+ acc (p i (expt 4 i)))))))

(let ((_ (solve 31)))
  (print _) (assert (= _ 1617243)))
