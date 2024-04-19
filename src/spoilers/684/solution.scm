(import
  (euler))

(define (S n m)
  (let ((a (quotient n 9)) (b (+ (modulo n 9) 2)))
    (modulo (* (- (modulo (* (+ (modulo (* (- b 1) b) m) 10) (modular-expt 10 a m)) m)
                  (modulo (* (+ (modulo (* 9 a) m) 4 b) 2) m))
               (modular-inverse 2 m))
      m)))

(define (solve n m)
  (let loop ((a 1) (b 1) (i 2) (acc 0))
    (if (> i n)
      acc
      (loop (+ a b) a (+ i 1) (modulo (+ acc (S a m)) m)))))

(let ((_ (solve 90 1000000007)))
  (print _) (assert (= _ 922058210)))
