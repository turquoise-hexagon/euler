(import
  (chicken fixnum))

(define (number-solutions n)
  (do ((a 0 (fx+ a 1))
       (r 0 (let ((_ (fx- n a)))
              (do ((b 0 (fx+ b 1))
                   (r r (let ((c (fx- _ b)))
                          (if (fx= (fx+ (fx* a a)
                                        (fx* b b))
                                   (fx* c c))
                            (fx+ r 1)
                            r))))
                ((fx> b _) r)))))
    ((fx> a n) r)))

(define (solve n)
  (let loop ((i 0) (tmp 0) (acc 0))
    (if (fx> i n)
      acc
      (let ((_ (number-solutions i)))
        (if (fx> _ tmp)
          (loop (fx+ i 1) _ i)
          (loop (fx+ i 1) tmp acc))))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 840)))
