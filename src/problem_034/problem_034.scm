(import
  (euler)
  (srfi 1))

(define factorials
  (list->vector
    (map factorial (range 0 9))))

(define upper-bound
  (let ((val (factorial 9)))
    (let loop ((i 1))
      (let ((tmp (expt 10 i)))
        (if (> tmp (* i val))
          tmp
          (loop (+ i 1)))))))

(define (valid? n)
  (=
    (apply +
      (map
        (lambda (i)
          (vector-ref factorials i))
        (number->list n)))
    n))

(define (solve)
  (apply + (filter valid? (range 3 upper-bound))))

(print (solve))
