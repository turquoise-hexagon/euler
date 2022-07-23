(define (generate n)
  (let ((array (make-vector (+ n 1) 0)))
    (do ((i 1 (+ i 1))) ((> i n))
      (do ((j i (+ j i))) ((> j n))
        (vector-set! array j (+ 1 (vector-ref array j)))))
    (vector->list array)))

(define (solve n)
  (let solve/h ((lst (generate n)) (acc 0))
    (if (null? (cdr lst)) acc
        (let ((a (car lst)) (b (cadr lst)))
          (solve/h (cdr lst) (if (= a b)
                                 (+ acc 1)
                                 acc))))))

(print (solve 10000000))
