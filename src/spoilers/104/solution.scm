(define-constant phi (/ (+ 1 (sqrt 5)) 2))
(define-constant log_phi_sqrt_5 (log (sqrt 5) phi))
(define-constant log_phi_10 (log 10 phi))

(define (pandigital? n)
  (let ((acc (make-vector 10 0)))
    (let loop ((n n))
      (let ((_ (modulo n 10)))
        (vector-set! acc _ (+ (vector-ref acc _) 1)))
      (unless (= n 0)
        (loop (quotient n 10))))
    (let loop ((i 0))
      (if (= i 10)
        #t
        (if (= (vector-ref acc i) 1)
          (loop (+ i 1))
          #f)))))

(define (last-9 n)
  (modulo n #e1e9))

(define (first-9 i n)
  (quotient n (expt 10 (- (inexact->exact (ceiling (/ (- i log_phi_sqrt_5) log_phi_10))) 9))))

(define (solve)
  (let loop ((a 1) (b 0) (i 1))
    (if (and (pandigital? (last-9 a))
             (pandigital? (first-9 i a)))
      i
      (loop (+ a b) a (+ i 1)))))

(let ((_ (solve)))
  (print _) (assert (= _ 329468)))
