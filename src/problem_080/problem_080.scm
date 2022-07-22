(import
  (srfi 1)
  (euler))

(define (square-root n digits)
  (let ((r (inexact->exact (floor (sqrt n)))))
    (let loop ((d r) (i n) (r r) (t r) (c digits) (acc '()))
      (let ((acc (cons d acc)))
        (let* ((i (* 100 (- i (* t d)))) (t (* 20 r))
               (d (- (find
                       (lambda (d)
                         (> (* d (+ t d)) i))
                       (range 1 10))
                     1)))
          (if (or (= i 0)
                  (= c 0))
            (reverse acc)
            (loop d i (+ (* 10 r) d) (+ t d) (- c 1) acc)))))))

(define (solve lim cnt)
  (apply +
    (map
      (lambda (i)
        (apply + (square-root i (- cnt 1))))
      (filter
        (lambda (i)
          (not (integer? (sqrt i))))
        (range 1 lim)))))

(print (solve 100 100))
