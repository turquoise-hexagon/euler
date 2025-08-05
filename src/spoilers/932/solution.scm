(import
  (chicken fixnum))

(define (concatenate a b)
  (do ((a a (fx* a 10))
       (i b (fx/ i 10)))
    ((fx= i 0)
     (fx+ a b))))

(define (valid? n)
  (let loop ((a n) (b 0) (m 1))
    (if (fx= a 0)
      #f
      (if (and (let ((_ (fx+ a b))) (fx= (fx* _ _) n)) (fx= (concatenate a b) n))
        #t
        (loop (fx/ a 10) (fx+ (fx* (fxmod a 10) m) b) (fx* m 10))))))

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
