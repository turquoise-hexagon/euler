(import
  (euler))

(define (solve n p)
  (let ((l (reverse (map add1 (number->list n p)))))
    (let loop ((i 0) (l l) (p (apply * l)) (acc 0))
      (if (null? l)
        acc
        (let* ((t (car l)) (p (quotient p t)))
          (loop (+ i 1) (cdr l) p
            (+ acc
               (quotient
                 (* (expt 28 i)
                    (- t 0)
                    (- t 1)
                    p)
                 2))))))))

(let ((_ (solve #e1e9 7)))
  (print _) (assert (= _ 2129970655314432)))
