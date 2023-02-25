(import
  (chicken fixnum)
  (euler))

(define (f n p)
  (let loop ((n n) (acc 0))
    (if (fx= n 0)
      acc
      (let ((_ (fx/ n p)))
        (loop _ (fx+ acc _))))))

(define (solve n m)
  (foldl
    (lambda (acc p)
      (fxmod (fx* acc (fx+ (modular-expt p (fx* 2 (f n p)) m) 1)) m))
    1 (primes n)))

(let ((_ (solve #e1e8 1000000009)))
  (print _) (assert (= _ 98792821)))
