(import (srfi 69))

(define (number->vector n)
  (let ((vec (make-vector 10 0)))
    (do ((x n (quotient x 10))) ((zero? x) vec)
      (let ((m (remainder x 10)))
        (vector-set! vec m (add1 (vector-ref vec m)))))))

(define (vector->number vec)
  (let ((len (vector-length vec)))
    (do ((x 0 (add1 x))
         (acc 0 (+ (* acc 10) (vector-ref vec x))))
      ((= x len) acc))))

(define (main n)
  (let ((hash (make-hash-table)))
    (let helper ((x 0))
      (let* ((v (* x x x))
             (k (vector->number (number->vector v)))
             (l (cons v (hash-table-ref/default hash k (list)))))
        (if (= (length l) n)
            (apply min l)
            (begin
              (hash-table-set! hash k l)
              (helper (add1 x))))))))

(display (main 5))
(newline)
