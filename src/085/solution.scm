(import
  (chicken fixnum)
  (euler))

(define-syntax f
  (syntax-rules ()
    ((_ a b)
     (fx/ (fx* (fx* a (fx+ a 1))
               (fx* b (fx+ b 1)))
          4))))

(define (solve n)
  (let loop ((a 1) (tmp n) (acc 0))
    (if (fx> (fx* a a) n)
      acc
      (let subloop ((b 1) (tmp tmp) (acc acc))
        (if (fx= a b)
          (loop (fx+ a 1) tmp acc)
          (let ((_ (fxabs (fx- n (f a b)))))
            (if (fx< _ tmp)
              (subloop (fx+ b 1) _ (fx* a b))
              (subloop (fx+ b 1) tmp acc))))))))

(let ((_ (solve #e2e6)))
  (print _) (assert (= _ 2772)))
