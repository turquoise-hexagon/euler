(import
  (euler))

(define (find-limit target)
  (inexact->exact (ceiling (/ target (log 2)))))

(define (make-search n)
  (let* ((target (* n (log n))) (primes (list->vector (primes (find-limit target)))))
    (lambda (i)
      (let loop ((a i) (b (- (vector-length primes) 1)))
        (if (< a b)
          (let* ((m (quotient (+ a b) 2))
                 (p (vector-ref primes i))
                 (q (vector-ref primes m)))
            (if (< target (+ (* p (log q)) (* q (log p))))
              (loop a m)
              (loop (+ m 1) b)))
          (- a 1))))))

(define (solve n)
  (let ((search (make-search n)))
    (let loop ((i 0) (acc 0))
      (let ((_ (search i)))
        (if (> _ i)
          (loop (+ i 1) (+ acc (- _ i)))
          acc)))))

(print (solve 800800))
