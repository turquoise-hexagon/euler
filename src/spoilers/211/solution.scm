(import
  (chicken fixnum))

(define (make-sigma2 l)
  (let ((acc (make-vector (fx+ l 1) 0)))
    (do ((i 1 (fx+ i 1))) ((fx> i l))
      (do ((j i (fx+ j i))) ((fx> j l))
        (vector-set! acc j (fx+ (vector-ref acc j) (fx* i i)))))
    (lambda (n)
      (vector-ref acc n))))

(define (square? n)
  (let loop ((i n))
    (let ((_ (fx/ (fx+ i (fx/ n i)) 2)))
      (if (fx< _ i)
        (loop _)
        (fx= (fx* _ _) n)))))

(define (solve l)
  (let ((sigma2 (make-sigma2 l)))
    (do ((i 1 (fx+ i 1))
         (acc 0 (if (square? (sigma2 i))
                  (fx+ acc i)
                  acc)))
      ((fx> i l) acc))))

(let ((_ (solve #e64e6)))
  (print _) (assert (= _ 1922364685)))
