(import
  (chicken fixnum))

(define-constant l #e1e6)

(define-inline (next n)
  (if (fxeven? n)
    (fx+ (chain (fx/ n 2)) 1)
    (fx+ (chain (fx+ (fx* n 3) 1)) 2)))

(define chain
  (let ((cache (make-vector (fx+ l 1))))
    (vector-set! cache 1 1)
    (lambda (n)
      (if (fx> n l)
        (next n)
        (let ((acc (vector-ref cache n)))
          (if (fixnum? acc)
            acc
            (let ((acc (next n)))
              (vector-set! cache n acc)
              acc)))))))

(define (solve l)
  (let loop ((i 1) (res 0) (acc 0))
    (if (fx> i l)
      acc
      (let ((tmp (chain i)))
        (if (fx> tmp res)
          (loop (fx+ i 1) tmp i)
          (loop (fx+ i 1) res acc))))))

(print (solve #e1e6))
