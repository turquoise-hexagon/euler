(import
  (chicken fixnum))

(define-constant l #e5e6)

(define-syntax next
  (syntax-rules ()
    ((_ n)
     (if (fxodd? n)
       (fx+ (fx* 3 n) 1)
       (fx/ n 2)))))

(define collatz
  (let ((cache (make-vector (fx+ l 1) #f)))
    (vector-set! cache 1 1)
    (lambda (n)
      (if (fx> n l)
        (fx+ (collatz (next n)) 1)
        (let ((acc (vector-ref cache n)))
          (if acc
            acc
            (let ((acc (fx+ (collatz (next n)) 1)))
              (vector-set! cache n acc)
              acc)))))))

(define (solve n)
  (let loop ((i 1) (res 0) (acc 0))
    (if (fx> i n)
      acc
      (let ((tmp (collatz i)))
        (if (fx> tmp res)
          (loop (fx+ i 1) tmp i)
          (loop (fx+ i 1) res acc))))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 837799)))
