(import (srfi 1)
        (euler))

(define (list->number lst)
  (string->number (apply string-append (map number->string lst))))

(define (rotations lst)
  (let rotations/h ((cnt (length lst)) (lst lst) (acc '()))
    (if (= cnt 0)
        acc
        (rotations/h (- cnt 1) (append (cdr lst) `(,(car lst))) (cons lst acc)))))

(define (circular-prime? n)
  (fold
    (lambda (a acc)
      (and a acc))
    #t (map prime? (map list->number (rotations (number->list n))))))

(define (solve n)
  (count circular-prime? (iota n)))

(print (solve 1000000))
