(import
  (chicken fixnum))

(define (solve n m)
  (let-values (((lim _) (exact-integer-sqrt n)))
    (let ((mem (make-vector (+ lim 1) 1)))
      (vector-set! mem 0 0)
      (let loop ((i lim))
        (unless (fx= i 0)
          (let loop ((t 2) (acc 0))
            (if (fx> t (fx/ lim i))
              (vector-set! mem i (fx- (fx/ n (fx* i i)) acc))
              (loop (fx+ t 1) (fx+ acc (vector-ref mem (fx* i t))))))
          (loop (fx- i 1))))
      (let loop ((i 0) (acc 0))
        (if (fx> i lim)
          acc
          (loop (fx+ i 1) (fxmod (fx+ acc (fx* (vector-ref mem i) (fx* i i))) m)))))))

(let ((_ (solve #e1e14 1000000007)))
  (print _) (assert (= _ 94586478)))
