(define (_solve n p)
  (let loop ((n n) (acc '()))
    (if (= n 0)
      (reverse acc)
      (loop (quotient n p) (cons (+ (modulo n p) 1) acc)))))

(define (solve n p)
  (let ((l (_solve n p)))
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
