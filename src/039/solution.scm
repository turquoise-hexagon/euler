(import
  (euler))

(define (number-solutions n)
  (do ((a 0 (+ a 1))
       (r 0 (let ((t (- n a)))
              (do ((b 0 (+ b 1))
                   (r r (let ((c (- t b)))
                          (if (= (+ (* a a) (* b b)) (* c c))
                            (+ r 1)
                            r))))
                ((> b t) r)))))
    ((> a n) r)))

(define (solve n)
  (extremum (range 1 n) number-solutions >))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 840)))
