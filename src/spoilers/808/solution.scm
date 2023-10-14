(import
  (chicken fixnum)
  (euler))

(define (reverse-number n)
  (let loop ((n n) (acc 0))
    (if (fx= n 0)
      acc
      (loop (fx/ n 10) (fx+ (fx* acc 10) (fxmod n 10))))))

(define (solve n)
  (let loop ((i 1) (cnt 0) (acc 0))
    (if (fx= cnt n)
      acc
      (let* ((s (fx* i i)) (r (reverse-number s)))
        (if (fx= s r)
          (loop (fx+ i 2) cnt acc)
          (let ((_ (fxsqrt r)))
            (if (and (fx= (fx* _ _) r)
                     (prime? i)
                     (prime? _))
              (loop (fx+ i 2) (fx+ cnt 1) (fx+ acc s))
              (loop (fx+ i 2) cnt acc))))))))

(let ((_ (solve 50)))
  (print _) (assert (= _ 3807504276997394)))
