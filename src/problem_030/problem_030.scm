(import
  (euler)
  (srfi 1))

(define (upper-bound e)
  (let ((val (expt 9 e)))
    (let loop ((i 1))
      (let ((tmp (expt 10 i)))
        (if (> tmp (* i val))
          tmp
          (loop (+ i 1)))))))

(define (valid? n e)
  (= (apply +
       (map
         (lambda (i)
           (expt i e))
         (number->list n)))
     n))

(define (solve e)
  (apply +
    (filter
      (lambda (n)
        (valid? n e))
      (range 2 (upper-bound e)))))

(print (solve 5))
