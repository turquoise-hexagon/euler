(define e 1504170715041707)
(define m 4503599627370517)

(define (solve)
  (let solve/h ((s e) (b e) (acc e))
    (if (= s 1) acc
        (let ((t (modulo (+ s b) m)))
          (cond ((> t b) (solve/h s t acc))
                ((< t s) (solve/h t b (+ acc t))))))))

(print (solve))
