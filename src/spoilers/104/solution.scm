(import
  (chicken bitwise))

(define-constant phi (/ (+ 1 (sqrt 5)) 2))
(define-constant log_phi_sqrt_5 (log (sqrt 5) phi))
(define-constant log_phi_10 (log 10 phi))

(define (pandigital? n)
  (if (= n 0)
    #f
    (let loop ((n n) (c 0) (d 0))
      (if (= n 0)
        (= d (- (arithmetic-shift 1 c) 1))
        (let ((t (bitwise-ior d (arithmetic-shift 1 (- (modulo n 10) 1)))))
          (if (= d t)
            #f
            (loop (quotient n 10) (+ c 1) t)))))))

(define (last-9 n)
  (modulo n #e1e9))

(define (first-9 i n)
  (quotient n (expt 10 (- (inexact->exact (ceiling (/ (- i log_phi_sqrt_5) log_phi_10))) 9))))

(define (solve)
  (let loop ((a 1) (b 0) (i 1))
    (if (> a #e1e9)
      (if (and (pandigital? (last-9 a))
               (pandigital? (first-9 i a)))
        i
        (loop (+ a b) a (+ i 1)))
      (loop (+ a b) a (+ i 1)))))

(let ((_ (solve)))
  (print _) (assert (= _ 329468)))
