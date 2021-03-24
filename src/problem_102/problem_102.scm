(import (chicken io)
        (chicken string)
        (matchable)
        (srfi 1))

(define-record point x y)

(define (parse-line str)
  (match (map string->number (string-split str ","))
    ((x1 y1 x2 y2 x3 y3)
     (list (make-point x1 y1)
           (make-point x2 y2)
           (make-point x3 y3)))))

(define (import-input)
  (map parse-line (read-lines)))

(define (sign a b c)
  (match-let
    ((($ point x1 y1) a)
     (($ point x2 y2) b)
     (($ point x3 y3) c))
    (- (* (- x1 x3) (- y2 y3))
       (* (- x2 x3) (- y1 y3)))))

(define (in-triangle? p triangle)
  (match triangle
    ((a b c)
     (let ((d1 (sign p a b))
           (d2 (sign p b c))
           (d3 (sign p c a)))
       (not (and (or (< d1 0) (< d2 0) (< d3 0))
                 (or (> d1 0) (> d2 0) (> d3 0))))))))

(define (solve input)
  (let ((orig (make-point 0 0)))
    (count (cut in-triangle? orig <>) input)))

(print (solve (import-input)))
