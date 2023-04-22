(import
  (euler))

(define (f n p)
  (let loop ((i p) (acc 0))
    (let ((_ (quotient n i)))
      (if (= _ 0)
        acc
        (loop (* i p) (+ acc _))))))

(define (g l n)
  (let loop ((l l) (acc 0))
    (if (null? l)
      acc
      (let ((i (car l)))
        (if (> i n)
          acc
          (loop (cdr l) (+ acc (* i (f n i)))))))))

(define (solve n k)
  (let ((l (primes (max n k))))
    (- (g l n)
       (g l k)
       (g l (- n k)))))

(let ((_ (solve #e2e7 #e15e6)))
  (print _) (assert (= _ 7526965179680)))
