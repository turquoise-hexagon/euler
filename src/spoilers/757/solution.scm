(import
  (chicken fixnum))

(define-inline (swap! v a b)
  (let ((m (vector-ref v a))
        (n (vector-ref v b)))
    (vector-set! v a n)
    (vector-set! v b m)))

(define (partition! v l h)
  (let ((p (vector-ref v (fx/ (fx+ l h) 2))))
    (let loop ((l l) (h h))
      (let ((l (do ((l l (fx+ l 1))) ((fx>= (vector-ref v l) p) l)))
            (h (do ((h h (fx- h 1))) ((fx<= (vector-ref v h) p) h))))
        (if (fx< l h)
          (begin
            (swap! v l h)
            (loop (fx+ l 1)
                  (fx- h 1)))
          h)))))

(define (main! v l h)
  (if (fx< l h)
    (let* ((p (partition! v l h)) (_ (fx+ p 1)))
      (main! v l p)
      (main! v _ h))))

(define (sort! v)
  (main! v 0 (fx- (vector-length v) 1)))

(define-constant limit #e2e8)

(define append!
  (let ((i 0))
    (lambda (v n)
      (vector-set! v i n)
      (set! i (fx+ i 1)))))

(define-inline (f a b)
  (fx* (fx* a (fx+ a 1))
       (fx* b (fx+ b 1))))

(define (result! v)
  (sort! v)
  (do ((i 1 (fx+ i 1))
       (c 0 (let ((_ (fx+ i 1)))
              (if (fx< (vector-ref v i)
                       (vector-ref v _))
                (fx+ c 1)
                c))))
    ((fx= i limit) (fx- c 1))))

(define (solve l)
  (let ((acc (make-vector limit 0)))
    (let loop/i ((i 1))
      (let loop/j ((j 1))
        (let ((_ (f i j)))
          (if (fx> _ l)
            (if (fx= j 1)
              (result! acc)
              (loop/i (fx+ i 1)))
            (begin
              (append! acc _)
              (loop/j (fx+ j 1)))))))))

(let ((_ (solve #e1e14)))
  (print _) (assert (= _ 75737353)))
