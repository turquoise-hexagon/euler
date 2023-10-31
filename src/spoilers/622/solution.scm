(import
  (euler))

(define (_multiplicative-order a e p)
  (let ((m (expt p e)) (t (* (- p 1) (expt p (- e 1)))))
    (foldl
      (lambda (acc _)
        (let ((e (car _))
              (p (cdr _)))
          (let loop ((i (modular-expt a (quotient t (expt p e)) m)) (acc acc))
            (if (= i 1)
              acc
              (loop (modular-expt i p m) (* acc p))))))
      1 (run-length (factors t)))))

(define (multiplicative-order a m)
  (apply lcm
    (map
      (lambda (_)
        (_multiplicative-order a (car _) (cdr _)))
      (run-length (factors m)))))

(define (solve n)
  (foldl
    (lambda (acc i)
      (if (= (multiplicative-order 2 i) n)
        (+ acc i 1)
        acc))
    0 (divisors (- (expt 2 n) 1))))

(let ((_ (solve 60)))
  (print _) (assert (= _ 3010983666182123972)))
