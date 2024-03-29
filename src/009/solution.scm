(define (solve n)
  (call/cc
    (lambda (_)
      (do ((i 1 (+ i 1))) ((>= i (/ n 3)))
        (do ((j i (+ j 1))) ((>= j (/ n 2)))
          (let ((k (- n i j)))
            (when (= (+ (* i i) (* j j)) (* k k))
              (_ (* i j k)))))))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 31875000)))
