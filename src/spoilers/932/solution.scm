(import
  (chicken fixnum))

(define (valid? n)
  (let loop ((a n) (b 0) (m 1) (t #f))
    (if (fx= a 0)
      #f
      (if (and t (fx= (fx* (fx+ a b) (fx+ a b)) n))
        #t
        (let ((d (fxmod a 10)))
          (loop (fx/ a 10) (fx+ (fx* d m) b) (fx* m 10) (fx> d 0)))))))

(define (solve nb-digits)
  (let ((l (expt 10 nb-digits)))
    (let loop ((i 2) (acc 0))
      (let ((_ (fx* i i)))
        (if (fx> _ l)
          acc
          (loop (fx+ i 1)
            (if (valid? _)
              (fx+ acc _)
              acc)))))))

(let ((_ (solve 16)))
  (print _) (assert (= _ 72673459417881349)))
