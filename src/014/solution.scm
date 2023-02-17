(import
  (srfi 69))

(define-syntax f
  (syntax-rules ()
    ((_ n)
     (if (even? n)
       (quotient n 2)
       (+ (* n 3) 1)))))

(define collatz
  (let ((cache (make-hash-table)))
    (hash-table-set! cache 1 1)
    (lambda (n)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let ((acc (+ (collatz (f n)) 1)))
          (hash-table-set! cache n acc)
          acc)))))

(define (solve n)
  (let loop ((i 1) (res 0) (acc 0))
    (if (> i n)
      acc
      (let ((tmp (collatz i)))
        (if (> tmp res)
          (loop (+ i 1) tmp i)
          (loop (+ i 1) res acc))))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 837799)))
