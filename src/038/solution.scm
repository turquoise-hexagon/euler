(import
  (chicken fixnum))

(define-constant limit 987654321)

(define (pandigital? n)
  (if (fx= n 0)
    #f
    (let loop ((n n) (c 0) (d 0))
      (if (fx= n 0)
        (fx= d (fx- (fxshl 1 c) 1))
        (let ((t (fxior d (fxshl 1 (fx- (fxmod n 10) 1)))))
          (if (fx= d t)
            #f
            (loop (fx/ n 10) (fx+ c 1) t)))))))

(define (concatenate a b)
  (let loop ((i b) (a a))
    (if (fx= i 0)
      (fx+ a b)
      (loop (fx/ i 10) (fx* a 10)))))

(define (generate n)
  (let loop ((i 2) (acc n))
    (let ((_ (concatenate acc (fx* n i))))
      (if (fx> _ limit)
        acc
        (loop (fx+ i 1) _)))))

(define (solve)
  (let loop ((i 1) (acc 0))
    (if (fx> i 9999)
      acc
      (loop (fx+ i 1)
        (let ((_ (generate i)))
          (if (pandigital? _)
            (fxmax _ acc)
            acc))))))

(let ((_ (solve)))
  (print _) (assert (= _ 932718654)))
