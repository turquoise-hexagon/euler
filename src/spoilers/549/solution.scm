(import
  (chicken fixnum))

(define (helper i j)
  (let loop ((x i) (y i))
    (if (fx= (fxmod x j) 0)
      y
      (let ((y (fx+ y i)))
        (loop (fx* x y) y)))))

(define (solve n)
  (let ((mem (make-vector (fx+ n 1) 0)))
    (do ((i 2 (fx+ i 1))) ((fx> i n))
      (when (fx= (vector-ref mem i) 0)
        (vector-set! mem i i)
        (do ((j i (fx* j i))) ((fx> j n))
          (do ((k 1 (fx+ k 1))) ((fx> (fx* j k) n))
            (vector-set! mem (fx* j k) (fxmax (helper i j) (vector-ref mem (fx* j k))))))))
    (do ((i 2 (fx+ i 1))
         (acc 0 (fx+ acc (vector-ref mem i))))
      ((fx> i n) acc))))

(let ((_ (solve #e1e8)))
  (print _) (assert (= _ 476001479068717)))
