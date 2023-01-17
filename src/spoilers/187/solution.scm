(import
  (euler))

(define (solve n)
  (let loop ((a (primes n)) (acc 0))
    (if (null? a)
      acc
      (loop (cdr a)
        (let subloop ((b a) (acc acc))
          (if (or (null? b) (> (* (car a) (car b)) n))
            acc
            (subloop (cdr b) (+ acc 1))))))))

(let ((_ (solve #e1e8)))
  (print _) (assert (= _ 17427258)))
