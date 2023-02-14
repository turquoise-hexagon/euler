(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define factorials (list->vector (map factorial (range 0 9))))

(define (sum-factorial-digits n)
  (let loop ((n n) (acc 0))
    (if (fx= n 0)
      acc
      (loop (fx/ n 10) (fx+ acc (vector-ref factorials (fxmod n 10)))))))

(define chain
  (let ((cache (make-hash-table)))
    (lambda (n)
      (let ((mem (make-hash-table)))
        (let loop ((n n))
          (if (hash-table-exists? cache n)
            (hash-table-ref cache n)
            (if (hash-table-exists? mem n)
              0
              (begin
                (hash-table-set! mem n #t)
                (let ((_ (fx+ (loop (sum-factorial-digits n)) 1)))
                  (hash-table-set! cache n _)
                  _)))))))))

(define (solve n)
  (let loop ((i 0) (acc 0))
    (if (fx> i n)
      acc
      (loop (fx+ i 1)
        (if (fx= (chain i) 60)
          (fx+ acc 1)
          acc)))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 402)))
