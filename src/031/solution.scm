(define (solve nums target)
  (let ((acc (make-vector (+ target 1) 0)))
    (vector-set! acc 0 1)
    (for-each
      (lambda (n)
        (do ((i n (+ i 1))) ((> i target))
          (vector-set! acc i (+ (vector-ref acc i) (vector-ref acc (- i n))))))
      nums)
    (vector-ref acc target)))

(let ((_ (solve '(1 2 5 10 20 50 100 200) 200)))
  (print _) (assert (= _ 73682)))
