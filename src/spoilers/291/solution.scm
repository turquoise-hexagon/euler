(import
  (chicken fixnum))

(define-inline (f n)
  (let ((_ (fx+ n 1)))
    (fx+ (fx* n n)
         (fx* _ _))))

(define-inline (helper! mem s v l)
  (do ((i s (fx+ i v))) ((fx> i l))
    (do ((acc (vector-ref mem i) (fx/ acc v)))
      ((not (fx= (fxmod acc v) 0))
       (vector-set! mem i acc)))))

(define (solve l)
  (let* ((l (inexact->exact (floor (/ (sqrt (* l 2)) 2)))) (mem (make-vector (fx+ l 1))))
    (do ((i 1 (fx+ i 1))) ((fx> i l))
      (vector-set! mem i (f i)))
    (let loop ((i 1) (acc 0))
      (if (fx> i l)
        acc
        (let ((v (vector-ref mem i)))
          (unless (fx= v 1)
            (let ((_ (fx- (fx- v i) 1)))
              (helper! mem i v l)
              (helper! mem _ v l)))
          (loop (fx+ i 1)
            (if (fx= v (f i))
              (fx+ acc 1)
              acc)))))))

(let ((_ (solve #e5e15)))
  (print _) (assert (= _ 4037526)))
