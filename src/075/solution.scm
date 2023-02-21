(import
  (chicken fixnum))

(define (solve n)
  (let ((mem (make-vector (fx+ n 1) 0)))
    (do ((i 2 (fx+ i 1))) ((fx> (fx* i i) n))
      (do ((j 1 (fx+ j 1))) ((fx> j i))
        (when (and (fxodd? (fx+ i j)) (fx= (fxgcd i j) 1))
          (let ((p (fx+ (fx+ (fx+ (fx* i i) (fx* j j))
                             (fx- (fx* i i) (fx* j j)))
                        (fx* (fx* i j) 2))))
            (do ((k 1 (fx+ k 1))) ((fx> (fx* k p) n))
              (vector-set! mem (fx* k p) (fx+ (vector-ref mem (fx* k p)) 1)))))))
    (let loop ((i 0) (acc 0))
      (if (fx> i n)
        acc
        (loop (fx+ i 1)
          (if (fx= (vector-ref mem i) 1)
            (fx+ acc 1)
            acc))))))

(let ((_ (solve #e15e5)))
  (print _) (assert (= _ 161667)))
