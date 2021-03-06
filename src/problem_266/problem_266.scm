(import (euler)
        (chicken sort))

(define (search vec n)
  (let search/h ((lo 0) (hi (- (vector-length vec) 1)))
    (if (< lo hi)
        (let ((mid (quotient (+ lo hi) 2)))
          (if (< n (vector-ref vec mid))
              (search/h lo mid)
              (search/h (+ mid 1) hi)))
        (vector-ref vec (- lo 1)))))

(define (solve n)
  (let* ((lst (primes n)) (lim (sqrt (apply * lst))))
    (define (solve/h i end acc)
      (if (= i end)
          (if (> lim acc)
              (list acc)
              (list))
          (append (solve/h (+ i 1) end (* acc (list-ref lst i)))
                  (solve/h (+ i 1) end acc))))
    (let ((len (length lst)))
      (let ((a (solve/h 0   (quotient len 2) 1))
            (b (solve/h (quotient len 2) len 1)))
        (let ((b (sort (list->vector b) <)))
          (foldl
            (lambda (acc i)
              (max (* i (search b (quotient lim i))) acc))
            0 a))))))

(print (modulo (solve 190) (expt 10 16)))
