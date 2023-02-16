(import
  (chicken fixnum))

(define-syntax t
  (syntax-rules ()
    ((_ n)
     (fx- (fx* 2 (fx* n n)) 1))))

(define-syntax f
  (syntax-rules ()
    ((_ t p)
     (let loop ((i t))
       (if (fx= (fxmod i p) 0)
         (loop (fx/ i p))
         i)))))

(define (solve n)
  (let ((mem (make-vector (fx+ n 1))))
    (do ((i 1 (fx+ i 1))) ((fx> i n))
      (vector-set! mem i (t i)))
    (let loop ((i 2) (acc 0))
      (if (fx> i n)
        acc
        (loop (fx+ i 1)
          (let ((v (vector-ref mem i)))
            (if (fx= v 1)
              acc
              (begin
                (vector-set! mem i (f v v))
                (do ((m v (fx+ m v))) ((fx> (fx- m i) n))
                  (unless (fx< (fx- m i) 0)
                    (vector-set! mem (fx- m i) (f (vector-ref mem (fx- m i)) v)))
                  (unless (fx> (fx+ m i) n)
                    (vector-set! mem (fx+ m i) (f (vector-ref mem (fx+ m i)) v))))
                (if (fx= v (t i))
                  (fx+ acc 1)
                  acc)))))))))

(let ((_ (solve #e5e7)))
  (print _) (assert (= _ 5437849)))
