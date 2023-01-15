(import
  (srfi 1))

(define (divisors n)
  (let ((acc (make-vector (+ n 1) 0)))
    (do ((i 1 (+ i 1))) ((> i n))
      (do ((j (+ i i) (+ j i))) ((> j n))
        (vector-set! acc j (+ (vector-ref acc j) i))))
    acc))

(define (solve n)
  (let ((divisors (divisors n)))
    (foldl
      (lambda (acc i)
        (let ((tmp (vector-ref divisors i)))
          (if (and (> n tmp) (not (= i tmp)) (= (vector-ref divisors tmp) i))
            (+ acc tmp)
            acc)))
      0 (iota n 1))))

(let ((_ (solve 10000)))
  (print _) (assert (= _ 31626)))
