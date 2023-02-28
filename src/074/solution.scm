(import
  (chicken fixnum)
  (euler))

(define-constant limit #e5e6)

(define factorials (list->vector (map factorial (range 0 9))))

(define (f n)
  (let loop ((n n) (acc 0))
    (if (fx= n 0)
      acc
      (loop (fx/ n 10) (fx+ acc (vector-ref factorials (fxmod n 10)))))))

(define chain
  (let ((cache (make-vector limit)))
    (lambda (n)
      (let loop ((n n) (acc '()))
        (let ((_ (vector-ref cache n)))
          (if (number? _)
            _
            (if (member n acc)
              0
              (let ((_ (fx+ (loop (f n) (cons n acc)) 1)))
                (vector-set! cache n _)
                _))))))))

(define (solve n)
  (let loop ((i 1) (acc 0))
    (if (fx> i n)
      acc
      (loop (fx+ i 1)
        (if (fx= (chain i) 60)
          (fx+ acc 1)
          acc)))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 402)))
