(import (chicken sort)
        (srfi 1))

(define (solve-pell n)
  (let ((x (inexact->exact (floor (sqrt n)))))
    (let solve-pell/h ((y x) (z 1) (r (+ x x)) (e1 1) (e2 0) (f1 0) (f2 1))
      (let* ((y (- (* r z) y))
             (z (quotient (- n (* y y)) z))
             (r (quotient (+ x y) z)))
        (let ((e1 e2) (e2 (+ e1 (* e2 r)))
              (f1 f2) (f2 (+ f1 (* f2 r))))
          (let ((a (+ (* f2 x) e2)) (b f2))
            (if (= (- (* a a) (* n b b)) 1) a
                (solve-pell/h y z r e1 e2 f1 f2))))))))

(define (solve n)
  (caar (sort (map
                (lambda (i)
                  (cons i (solve-pell i)))
                (filter
                  (lambda (i)
                    (not (integer? (sqrt i))))
                  (iota n 1)))
              (lambda (a b)
                (apply > (map cdr (list a b)))))))

(print (solve 1000))
