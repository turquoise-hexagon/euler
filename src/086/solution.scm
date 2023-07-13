(import
  (chicken fixnum)
  (euler))

(define (square? n)
  (let ((_ (fxsqrt n)))
    (fx= n (fx* _ _))))

(define (solve n)
  (do ((a 1 (fx+ a 1))
       (s 0 (do ((b 1 (fx+ b 1))
                 (s s (if (square? (fx+ (fx* a a) (fx* b b)))
                        (if (fx> a b)
                          (fx+ s (fx/ b 2))
                          (fx+ s (fx+ (fx- a (fx/ (fx+ b 1) 2)) 1)))
                        s)))
              ((fx> b (fx* a 2)) s))))
    ((fx> s n) (fx- a 1))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 1818)))
