(import
  (chicken fixnum))

(define (solve n)
  (let ((acc (make-vector (fx+ n 1) 0))
        (mem (make-vector (fx+ n 1) 0)))

    (define (_ s m)
      (do ((i (fxmod s m) (fx+ i m))) ((fx> i n))
        (when (fx= (fxmod (vector-ref mem i) m) 0)
          (vector-set! acc i (fxmax (vector-ref acc i) m))
          (do ((t (vector-ref mem i) (fx/ t m)))
            ((fx> (fxmod t m) 0) (vector-set! mem i t))))))

    (do ((i 0 (fx+ i 1))) ((fx> i n))
      (vector-set! mem i (fx+ (fx* 4 (fx* i i)) 1)))

    (do ((i 1 (fx+ i 1))) ((fx> i n))
      (when (fx> (vector-ref mem i) 1)
        (_ (fx- 0 i) (vector-ref mem i))
        (_ (fx+ 0 i) (vector-ref mem i))))

    (do ((i 1 (fx+ i 1))
         (s 0 (fxmod (fx+ s (vector-ref acc i)) #e1e18)))
      ((fx> i n) s))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 238518915714422000)))
