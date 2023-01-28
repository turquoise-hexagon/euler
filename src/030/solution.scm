(import
  (chicken fixnum)
  (euler))

(define (digits e)
  (list->vector
    (map
      (lambda (i)
        (expt i e))
      (range 0 9))))

(define (bounds d)
  (let loop ((a 0) (b 0))
    (if (fx> a b)
      a
      (loop (fx+ (fx* a 10) 9) (fx+ b (vector-ref d 9))))))

(define (valid? n d)
  (let loop ((i n) (acc 0))
    (if (fx= i 0)
      (fx= n acc)
      (loop (fx/ i 10) (fx+ acc (vector-ref d (fxmod i 10)))))))

(define (solve e)
  (let* ((d (digits e)) (b (bounds d)))
    (let loop ((i 2) (acc 0))
      (if (fx> i b)
        acc
        (loop (fx+ i 1)
          (if (valid? i d)
            (fx+ acc i)
            acc))))))

(let ((_ (solve 5)))
  (print _) (assert (= _ 443839)))
