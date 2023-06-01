(import
  (chicken fixnum))

(define (PHI n)
  (let ((mem (make-vector (fx+ n 1))))
    (do ((i 1 (fx+ i 1))) ((fx> i n))
      (vector-set! mem i i))
    (do ((i 2 (fx+ i 1)) (acc 1 (fx+ acc (vector-ref mem i))))
      ((fx> i n) acc)
      (when (fx= (vector-ref mem i) i)
        (do ((m i (fx+ m i))) ((fx> m n))
          (let ((_ (vector-ref mem m)))
            (vector-set! mem m (fx- _ (fx/ _ i)))))))))

(define (solve n)
  (fx* 6 (fx- (fx/ (fx* n (fx+ n 1)) 2) (PHI n))))

(let ((_ (solve #e1e8)))
  (print _) (assert (= _ 11762187201804552)))
