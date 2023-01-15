(import
  (euler))

(define (solve n)
  (let loop ((i 2) (tmp 1) (acc 2))
    (if (> i n)
      (digitsum acc)
      (loop (+ i 1) acc
        (+ (* (if (= (modulo i 3) 0)
                (* 2 (/ i 3))
                1)
             acc)
           tmp)))))

(let ((_ (solve 100)))
  (print _) (assert (= _ 272)))
