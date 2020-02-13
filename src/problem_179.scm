(import (srfi 1))

(define (main n)
  (let ((array (make-vector (add1 n) 0)))
    (for-each
      (lambda (x)
        (for-each
          (lambda (y)
            (vector-set! array y (add1 (vector-ref array y))))
          (do ((t x (+ t x))
               (acc (list) (cons t acc)))
            ((> t n) acc))))
      (iota (quotient n 2) 1 1))
    (let ((len (sub1 (vector-length array))))
      (do ((x 1 (add1 x))
           (acc 0 (if (= (vector-ref array x) (vector-ref array (add1 x)))
                      (add1 acc)
                      acc)))
        ((= x len) acc)))))

(display (main (expt 10 7)))
(newline)
