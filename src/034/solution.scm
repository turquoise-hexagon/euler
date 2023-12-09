(import
  (chicken fixnum)
  (euler))

(define factorials (list->vector (map factorial (range 9))))

(define limit
  (let ((_ (vector-ref factorials 9)))
    (let loop ((a 1) (b 1))
      (if (fx> a b)
        a
        (loop (fx* a 10) (fx+ b _))))))

(define (valid? n)
  (let loop ((i n) (acc 0))
    (if (fx= i 0)
      (fx= acc n)
      (loop (fx/ i 10) (fx+ acc (vector-ref factorials (fxmod i 10)))))))

(define (solve)
  (let loop ((i 3) (acc 0))
    (if (fx> i limit)
      acc
      (loop (fx+ i 1)
        (if (valid? i)
          (fx+ acc i)
          acc)))))

(let ((_ (solve)))
  (print _) (assert (= _ 40730)))
