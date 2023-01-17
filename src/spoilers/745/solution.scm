(import
  (euler))

(define (helper lim array n i)
  (- (floor (/ n (* i i)))
     (foldl + 0
       (map
         (lambda (j)
           (vector-ref array (* i j)))
         (range 2 (floor (/ lim i)) 1)))))

(define (S n)
  (let* ((lim (inexact->exact (floor (sqrt n)))) (acc (make-vector (+ lim 1) 1)))
    (vector-set! acc 0 0)
    (for-each
      (lambda (i)
        (vector-set! acc i (helper lim acc n i)))
      (range lim 1 -1))
    (foldl + 0
      (map
        (lambda (i)
          (* i i (vector-ref acc i)))
        (range 0 lim)))))

(define (solve n)
  (modulo (S n) 1000000007))

(let ((_ (solve #e1e14)))
  (print _) (assert (= _ 94586478)))
