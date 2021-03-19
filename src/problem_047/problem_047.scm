(import (euler)
        (srfi 1))

(define (nb-distinct-factors n)
  (length (delete-duplicates (factorize n) =)))

(define (solve n)
  (let solve/1/h ((i 0))
    (let ((len (let solve/2/h ((i i) (acc 0))
                 (if (not (= (nb-distinct-factors i) n)) acc
                     (solve/2/h (+ i 1) (+ acc 1))))))
      (if (= len n) i
          (solve/1/h (+ i (if (= len 0) 1 len)))))))

(print (solve 4))
