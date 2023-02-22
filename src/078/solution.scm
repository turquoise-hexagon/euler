(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define partition 
  (let ((cache (make-hash-table)))
    (hash-table-set! cache 0 1)
    (hash-table-set! cache 1 1)
    (lambda (n m)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let loop ((i 1) (acc 0))
          (if (fx> i n)
            (let ((acc (fxmod acc m)))
              (hash-table-set! cache n acc)
              acc)
            (let*
              ((a (fx- n (fx/ (fx* i (fx- (fx* 3 i) 1)) 2)))
               (b (fx- n (fx/ (fx* i (fx+ (fx* 3 i) 1)) 2)))
               (acc (fx+ acc (fx* (if (fxeven? i)
                                    -1
                                    +1)
                                (fx+ (partition a m)
                                     (partition b m))))))
              (if (and (fx< a 0)
                       (fx< b 0))
                (let ((acc (fxmod acc m)))
                  (hash-table-set! cache n acc)
                  acc)
                (loop (fx+ i 1) acc)))))))))

(define (solve n)
  (let loop ((i 1))
    (if (fx= (partition i n) 0)
      i
      (loop (fx+ i 1)))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 55374)))
