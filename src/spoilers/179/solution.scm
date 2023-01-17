(define (generate n)
  (let ((acc (make-vector (+ n 1) 0)))
    (do ((i 1 (+ i 1))) ((> i n))
      (do ((j i (+ j i))) ((> j n))
        (vector-set! acc j (+ (vector-ref acc j) 1))))
    (vector->list acc)))

(define (solve n)
  (let loop ((lst (generate n)) (acc 0))
    (if (null? (cdr lst))
      acc
      (loop (cdr lst)
        (if (= (car lst) (cadr lst))
          (+ acc 1)
          acc)))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 986262)))
