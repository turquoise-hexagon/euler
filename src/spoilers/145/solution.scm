(import
  (chicken fixnum))

(define (reverse-number n)
  (let loop ((n n) (acc 0))
    (if (fx= n 0)
      acc
      (loop (fx/ n 10) (fx+ (fx* acc 10) (fxmod n 10))))))

(define (reversible? n)
  (if (fx= (fxmod n 10) 0)
    #f
    (let loop ((n (fx+ n (reverse-number n))))
      (if (fx= n 0)
        #t
        (if (fx= (fxmod (fxmod n 10) 2) 0)
          #f
          (loop (fx/ n 10)))))))

(define (solve n)
  (let loop ((i 0) (acc 0))
    (if (fx> i n)
      acc
      (loop (fx+ i 1)
        (if (reversible? i)
          (fx+ acc 1)
          acc)))))

(let ((_ (solve #e1e9)))
  (print _) (assert (= _ 608720)))
