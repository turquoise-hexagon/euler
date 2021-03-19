(import (srfi 1))

(define (solve n)
  (call/cc
    (lambda (return)
      (do ((i 1 (+ i 1))) ((= i n))
        (do ((j i (+ j 1))) ((= j n))
          (do ((k j (+ k 1))) ((= k n))
            (when (and (= (+ (* i i) (* j j)) (* k k)) (= (+ i j k) n))
              (return (* i j k)))))))))
  
(print (solve 1000))
