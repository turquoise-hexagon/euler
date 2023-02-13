(import
  (chicken fixnum))

(define-constant limit 987654321)

(define (pandigital? n)
  (let ((acc (make-vector 10 0)))
    (let loop ((n n))
      (let ((_ (fxmod n 10)))
        (vector-set! acc _ (fx+ (vector-ref acc _) 1)))
      (unless (fx= n 0)
        (loop (fx/ n 10))))
    (let loop ((i 0))
      (if (fx= i 10)
        #t
        (if (fx= (vector-ref acc i) 1)
          (loop (fx+ i 1))
          #f)))))

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
