(import
  (euler)
  (srfi 69))

(define (next-prime n)
  (do ((i (+ n 1) (+ i 1)))
    ((prime? i) i)))

(define (solve limit)
  (let ((lst (primes (next-prime (fxsqrt limit)))) (acc (make-hash-table #:initial 0)))
    (for-each
      (lambda (a b)
        (let ((l (* a a))
              (h (* b b)))
          (do ((i (+ l a) (+ i a))) ((> i h)) (hash-table-update! acc i add1))
          (do ((i (- h b) (- i b))) ((< i l)) (hash-table-update! acc i add1))))
      lst (cdr lst))
    (hash-table-fold acc
      (lambda (i cnt acc)
        (if (and (= cnt 1) (<= i limit))
          (+ acc i)
          acc))
      0)))

(let ((_ (solve 999966663333)))
  (print _) (assert (= _ 1259187438574927161)))
