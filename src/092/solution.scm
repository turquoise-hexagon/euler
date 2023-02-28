(import
  (chicken fixnum))

(define (f n)
  (let loop ((n n) (acc 0))
    (if (fx= n 0)
      acc
      (loop (fx/ n 10)
        (let ((_ (fxmod n 10)))
          (fx+ acc (fx* _ _)))))))

(define (make-valid? n)
  (let ((acc (make-vector (fx+ n 1))))
    (vector-set! acc 1  #f)
    (vector-set! acc 89 #t)
    (define (valid? n)
      (let ((_ (vector-ref acc n)))
        (if (boolean? _)
          _
          (let ((_ (valid? (f n))))
            (vector-set! acc n _)
            _))))
    valid?))

(define (solve n)
  (let ((valid? (make-valid? n)))
    (let loop ((i 1) (acc 0))
      (if (fx> i n)
        acc
        (loop (fx+ i 1)
          (if (valid? i)
            (fx+ acc 1)
            acc))))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 8581146)))
