(import
  (chicken fixnum))

(define-inline (2d-ref acc a b)
  (vector-ref  (vector-ref acc a) b))

(define-inline (2d-set! acc a b i)
  (vector-set! (vector-ref acc a) b i))

(define (solve l m)
  (let ((acc (make-vector (fx+ l 1))))
    (do ((i 0 (fx+ i 1))) ((fx> i l))
      (vector-set! acc i (make-vector (fx+ l 1) 0)))
    (2d-set! acc 1 1 1)
    (do ((a 2 (fx+ a 1))) ((fx> a l))
      (do ((b 1 (fx+ b 1))) ((fx> b a))
        (2d-set! acc a b
          (fxmod
            (fx+
              (if (fx> b 1) (2d-ref acc (fx- a 0) (fx- b 1)) 0)
              (if (fx< b a) (2d-ref acc (fx- a 1) (fx- a b)) 0))
            m))))
    (2d-ref acc l l)))

(let ((_ (solve 24680 1020202009)))
  (print _) (assert (= _ 773479144)))
