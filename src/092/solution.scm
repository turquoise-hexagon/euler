(import
  (chicken fixnum)
  (srfi 69))

(define (f n)
  (let loop ((n n) (acc 0))
    (if (fx= n 0)
      acc
      (loop (fx/ n 10)
        (let ((_ (fxmod n 10)))
          (fx+ acc (fx* _ _)))))))

(define (make-chain)
  (let ((cache (make-hash-table)))
    ;; init cache
    (hash-table-set! cache  1 #f)
    (hash-table-set! cache 89 #t)
    (define (chain n)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let ((_ (chain (f n))))
          (hash-table-set! cache n _)
          _)))
    chain))

(define (solve n)
  (let ((chain (make-chain)))
    (let loop ((i 1) (acc 0))
      (if (fx> i n)
        acc
        (loop (fx+ i 1)
          (if (chain i)
            (fx+ acc 1)
            acc))))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 8581146)))
