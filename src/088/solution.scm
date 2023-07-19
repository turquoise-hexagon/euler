(import
  (chicken fixnum)
  (srfi 69))

(define (solve l)
  (let ((m (make-vector (fx+ l 1) most-positive-fixnum)))

    (let loop ((a 1) (b 1) (c 1) (d 2))
      (let ((_ (fx+ (fx- a b) c)))
        (unless (fx> _ l)
          (vector-set! m _ (fxmin a (vector-ref m _)))
          (let ((_ (fx* (fx/ l a) 2)))
            (do ((i d (fx+ i 1))) ((fx> i _))
              (loop (fx* a i) (fx+ b i) (fx+ c 1) i))))))

    (let ((t (make-hash-table)))
      (do ((i 2 (fx+ i 1))) ((fx> i l))
        (hash-table-set! t (vector-ref m i) #t))
      (foldl fx+ 0 (hash-table-keys t)))))

(let ((_ (solve 12000)))
  (print _) (assert (= _ 7587457)))
