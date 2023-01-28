(import
  (euler))

(define (solve n)
  (let ((s (expt 10 (- n 1))) (e (- (expt 10 n) 1)))
    (let loop ((i s) (acc '()))
      (if (> i e)
        (apply max acc)
        (let subloop ((j i) (acc acc))
          (if (> j e)
            (loop (+ i 1) acc)
            (subloop (+ j 1)
              (let ((_ (* i j)))
                (if (palindrome? _)
                  (cons _ acc)
                  acc)))))))))

(let ((_ (solve 3)))
  (print _) (assert (= _ 906609)))
