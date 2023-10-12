(import
  (chicken fixnum))

(define-inline (next n)
  (fx- (fx* 3 (A (fx- n 2))) (A (fx- n 4))))

(define (make-A l m)
  (let ((cache (make-vector (fx+ l 1) #f)))
    (vector-set! cache 0 0)
    (vector-set! cache 1 1)
    (vector-set! cache 2 1)
    (vector-set! cache 3 4)
    (define (A n)
      (let ((acc (vector-ref cache n)))
        (if acc
          acc
          (let ((acc (fxmod (next n) m)))
            (vector-set! cache n acc)
            acc))))
    A))

(define (make-M l m)
  (let ((A (make-A l m)))
    (lambda (n)
      (if (fxeven? n)
        (A (fx/ n 2))
        1))))

(define (solve l m)
  (let ((M (make-M l m)))
    (let loop ((i 1) (acc 2))
      (if (fx> i l)
        acc
        (loop (fx+ i 1) (fxmod (fx* acc (M i)) m))))))

(let ((_ (solve #e1e6 1234567891)))
  (print _) (assert (fx= _ 29894398)))
