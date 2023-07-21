(import
  (chicken fixnum)
  (euler))

(define (solve type limit)
  (let loop ((i 1) (l (primes type)))
    (if (fx> i limit)
      0
      (let subloop ((l l) (acc 1))
        (if (null? l)
          acc
          (subloop (cdr l) (fx+ acc (loop (fx* i (car l)) l))))))))

(let ((_ (solve 100 #e1e9)))
  (print _) (assert (= _ 2944730)))
