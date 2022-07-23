(import
  (euler)
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
    (extremum (range 1 n) (lambda (_) (length (chain divisors n _))) >)))

(print (solve 1000000))
