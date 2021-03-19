(import (chicken sort)
        (euler)
        (srfi 69))

(define (number->key n)
  (sort (number->list n) <))

(define (solve n)
  (let ((hash (make-hash-table)))
    (let solve/h ((i 0))
      (let* ((val (* i i i)) (key (number->key val)))
        (hash-table-set! hash key (cons val (hash-table-ref/default hash key '())))
        (let ((lst (hash-table-ref hash key)))
          (if (= (length lst) n)
              (apply min lst)
              (solve/h (+ i 1))))))))

(print (solve 5))
