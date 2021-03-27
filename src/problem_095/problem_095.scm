(import (srfi 1))

(define (generate n)
  (let ((array (make-vector (+ n 1) 0)))
    (do ((i 1 (+ i 1))) ((> i n))
      (do ((j (+ i i) (+ j i))) ((> j n))
        (vector-set! array j (+ (vector-ref array j) i))))
    array))

(define (chain array n lim)
  (let chain/h ((i n) (acc (list n)))
    (let ((t (vector-ref array i)))
      (if (> t lim) '()
          (if (> (count (cut = <> t) acc) 1) '()
              (if (= t n) acc
                  (chain/h t (cons t acc))))))))

(define (solve n)
  (let ((array (generate n)))
    (let solve/h ((i 1) (len 0) (acc 0))
      (if (> i n) acc
          (let* ((lst (chain array i n)) (tmp (length lst)))
            (if (> tmp len)
                (solve/h (+ i 1) tmp (apply min lst))
                (solve/h (+ i 1) len acc)))))))

(print (solve 1000000))
