(import
  (euler)
  (srfi 1))

(define (powers e)
  (list->vector
    (map
      (lambda (i)
        (expt i e))
      (range 0 9))))

(define (upper-bound e)
  (let ((val (expt 9 e)))
    (let loop ((i 1))
      (let ((tmp (expt 10 i)))
        (if (> tmp (* i val))
          tmp
          (loop (+ i 1)))))))

(define (valid? n powers)
  (= (apply +
       (map
         (lambda (i)
           (vector-ref powers i))
         (number->list n)))
     n))

(define (solve e)
  (let ((powers (powers e)))
    (apply +
      (filter
        (lambda (n)
          (valid? n powers))
        (range 2 (upper-bound e))))))

(print (solve 5))
