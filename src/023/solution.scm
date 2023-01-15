(import
  (srfi 1))

(define (divisors n)
  (let ((acc (make-vector n 0)))
    (do ((i 1 (+ i 1))) ((>= i n))
      (do ((j (+ i i) (+ j i))) ((>= j n))
        (vector-set! acc j (+ (vector-ref acc j) i))))
    (vector->list acc)))

(define (abundants n)
  (fold
    (lambda (sum i acc)
      (if (> sum i)
        (cons i acc)
        acc))
    '() (divisors n) (iota n)))

(define (solve n)
  (let ((acc (list->vector (iota n))) (lst (abundants n)))
    (for-each
      (lambda (i)
        (for-each
          (lambda (j)
            (let ((tmp (+ i j)))
              (when (< tmp n)
                (vector-set! acc tmp 0))))
          lst))
      lst)
    (apply + (vector->list acc))))


(let ((_ (solve 28123)))
  (print _) (assert (= _ 4179871)))
