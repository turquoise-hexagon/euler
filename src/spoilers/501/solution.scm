(import
  (euler))

(define l (primes #e1e6))

(define (a n)
  (let loopa ((la l) (acc 0))
    (let ((a (car la)))
      (if (> (expt a 3) n)
        acc
        (let loop/b ((lb (cdr la)) (acc acc))
          (let* ((b (car lb)) (c (quotient n (* a b))))
            (if (<= c b)
              (loopa (cdr la) acc)
              (let ((_ (- (prime-pi c)
                          (prime-pi b))))
                (loop/b (cdr lb) (+ acc _))))))))))

(define (b n)
  (let loop ((l l) (acc 0))
    (let* ((a (car l)) (b (quotient n (expt a 3))))
      (if (<= b 1)
        acc
        (loop (cdr l)
          (let ((_ (prime-pi b)))
            (if (>= b a)
              (+ acc _ -1)
              (+ acc _))))))))

(define (c n)
  (let loop ((l l) (acc 0))
    (if (> (expt (car l) 7) n)
      acc
      (loop (cdr l) (+ acc 1)))))

(define (solve n)
  (+ (a n)
     (b n)
     (c n)))

(let ((_ (solve #e1e12)))
  (print _) (assert (= _ 197912312715)))
