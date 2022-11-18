(import
  (euler)
  (srfi 69))

(define factorials
  (list->vector (map factorial (range 0 9))))

(define (sum-factorials-digits n)
  (let loop ((i n) (acc 0))
    (if (= i 0)
      acc
      (let ((q (quotient i 10)) (m (modulo i 10)))
        (loop q (+ acc (vector-ref factorials m)))))))

(define (chain n)
  (let ((mem (make-hash-table)))
    (let loop ((i n) (acc 0))
      (if (hash-table-exists? mem i)
        acc
        (begin
          (hash-table-set! mem i #t)
          (loop (sum-factorials-digits i)
            (+ acc 1)))))))

(define (solve lim cnt)
  (let loop ((i 1) (acc 0))
    (if (> i lim)
      acc
      (loop (+ i 1)
        (if (= (chain i) cnt)
          (+ acc 1)
          acc)))))

(print (solve 1000000 60))
