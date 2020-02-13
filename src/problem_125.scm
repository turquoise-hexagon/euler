(import (euler))

(define (squares n)
  (let helper ((x 0) (acc (list)))
    (let ((t (* x x)))
      (if (> t n)
          acc
          (helper (add1 x) (cons t acc))))))

(define (summable? lst n)
  (let helper ((lst lst))
    (if (null? lst)
        #f
        (let helper-2 ((lst-2 lst) (acc 0))
          (cond ((= acc n) #t)
                ((or (null? lst-2)
                     (> acc n)
                     (= (car lst-2) n))
                 (helper (cdr lst)))
                (else (helper-2 (cdr lst-2) (+ acc (car lst-2)))))))))

(define (main n)
  (let ((lst (squares n)))
    (do ((x 0 (add1 x))
         (acc 0 (if (and (palindrome? x)
                         (summable? lst x))
                    (+ acc x)
                    acc)))
      ((= x n) acc))))

(display (main (expt 10 8)))
(newline)
