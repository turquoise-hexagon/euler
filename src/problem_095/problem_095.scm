(import
  (srfi 1))

(define (divisors n)
  (let ((acc (make-vector (+ n 1) 0)))
    (do ((i 1 (+ i 1))) ((> i n))
      (do ((j (+ i i) (+ j i))) ((> j n))
        (vector-set! acc j (+ (vector-ref acc j) i))))
    acc))

(define (chain divisors limit n)
  (let loop ((i n) (acc (list n)))
    (let ((tmp (vector-ref divisors i)))
      (if (> tmp limit)
        '()
        (if (> (count (lambda (_) (= _ tmp)) acc) 1)
          '()
          (if (= tmp n)
            acc
            (loop tmp (cons tmp acc))))))))

(define (solve n)
  (let ((divisors (divisors n)))
    (let loop ((i 1) (cur 0) (acc 0))
      (if (> i n)
        (apply min acc)
        (let* ((lst (chain divisors n i)) (len (length lst)))
          (if (> len cur)
            (loop (+ i 1) len lst)
            (loop (+ i 1) cur acc)))))))

(print (solve 1000000))
