(import
  (chicken fixnum)
  (euler))

(define (order n)
  (let loop ((i 1))
    (let ((_ (fx* i 10)))
      (if (fx> _ n)
        i
        (loop _)))))

(define (valid? n)
  (let loop ((a n) (b n) (d (order n)))
    (if (fx= a 0)
      #t
      (if (and (prime? a)
               (prime? b))
        (loop (fx/ a 10) (fxmod b d) (fx/ d 10))
        #f))))

(define (solve)
  (let loop ((i 9) (cnt 0) (acc 0))
    (if (fx= cnt 11)
      acc
      (if (valid? i)
        (loop (fx+ i 2) (fx+ cnt 1) (fx+ acc i))
        (loop (fx+ i 2) cnt acc)))))

(let ((_ (solve)))
  (print _) (assert (= _ 748317)))
