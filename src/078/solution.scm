(import
  (euler)
  (srfi 69))

(define (make-partition)
  (let ((cache (make-hash-table)))
    (hash-table-set! cache 0 1)
    (hash-table-set! cache 1 1)
    (define (partition n)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let loop ((i 1) (acc 0))
          (if (> i n)
            (begin
              (hash-table-set! cache n acc)
              acc)
            (let*
              ((a (- n (quotient (* i (- (* 3 i) 1)) 2)))
               (b (- n (quotient (* i (+ (* 3 i) 1)) 2)))
               (acc (+ acc (* (if (even? i)
                                -1
                                +1)
                              (+ (partition a)
                                 (partition b))))))
              (if (and (< a 0)
                       (< b 0))
                (begin
                  (hash-table-set! cache n acc)
                  acc)
                (loop (+ i 1) acc)))))))
    partition))

(define (solve n)
  (let ((partition (make-partition)))
    (let loop ((i 1))
      (if (= (modulo (partition i) n) 0)
        i
        (loop (+ i 1))))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 55374)))
