(import
  (chicken fixnum)
  (euler))

(define (triangle n)
  (fx/ (fx* n (fx+ n 1)) 2))

(define divisors-count
  (let ((l (primes #e1e5)))
    (lambda (n)
      (let loop ((n n) (l l) (acc 1))
        (if (fx= n 1)
          acc
          (let ((p (car l)))
            (if (fx> (fx* p p) n)
              (fx* acc 2)
              (let subloop ((n n) (tmp 1))
                (if (fx= (fxmod n p) 0)
                  (subloop (fx/ n p) (fx+ tmp 1))
                  (loop n (cdr l) (fx* acc tmp)))))))))))

(define (divisors-count/triangle n)
  (if (fxeven? n)
    (fx* (divisors-count (fx+ n 1))
         (divisors-count (fx/ n 2)))
    (fx* (divisors-count n)
         (divisors-count (fx/ (fx+ n 1) 2)))))

(define (solve n)
  (let loop ((i 1))
    (if (fx> (divisors-count/triangle i) n)
      (triangle i)
      (loop (fx+ i 1)))))

(let ((_ (solve 500)))
  (print _) (assert (= _ 76576500)))
