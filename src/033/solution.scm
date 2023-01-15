(import
  (euler)
  (srfi 1))

(define (valid? a b)
  (if (= (remainder a 10)
         (quotient  b 10))
    (let ((q (quotient  a 10))
          (r (remainder b 10)))
      (if (= r 0)
        #f
        (= (/ a b) (/ q r))))
    #f))

(define (solve)
  (let ((_ (filter
             (lambda (pair)
               (apply valid? pair))
             (combinations (range 10 99) 2))))
    (denominator (apply / (apply map * _)))))

(let ((_ (solve)))
  (print _) (assert (= _ 100)))
