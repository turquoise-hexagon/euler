(import (srfi 1))

(define (pentagonal n)
  (* n (- (* 3 n) 1) 1/2))

(define (pentagonal? n)
  (integer? (/ (+ (sqrt (+ (* 24 n) 1)) 1) 6)))

(define (solve)
  (call/cc
    (lambda (return)
      (let solve/h ((i 1))
        (let ((x (pentagonal i)))
          (for-each
            (lambda (j)
              (let ((y (pentagonal j)))
                (when (and (pentagonal? (+ x y))
                           (pentagonal? (- x y)))
                  (return (abs (- x y))))))
            (iota i 1)))
        (solve/h (+ i 1))))))

(print (solve))
