(import
  (euler))

(define (solve n)
  (let ((l (expt 10 (- n 1)))
        (h (- (expt 10 n) 1)))
    (do ((a l (+ a 1))
         (acc 0 (do ((b a (+ b 1))
                     (acc acc (let ((_ (* a b)))
                                (if (and (> _ acc) (palindrome? _))
                                  _
                                  acc))))
                  ((> b h) acc))))
      ((> a h) acc))))

(let ((_ (solve 3)))
  (print _) (assert (= _ 906609)))
