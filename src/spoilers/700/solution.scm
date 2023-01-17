(define (solve n m)
  (let loop ((a n) (b n) (acc n))
    (if (= a 1)
      acc
      (let ((t (modulo (+ a b) m)))
        (cond
          ((> t b) (loop a t acc))
          ((< t a) (loop t b (+ acc t))))))))

(let ((_ (solve 1504170715041707 4503599627370517)))
  (print _) (assert (= _ 1517926517777556)))
