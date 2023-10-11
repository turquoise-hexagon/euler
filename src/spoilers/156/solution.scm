(import
  (chicken fixnum)
  (euler))

(define-inline (_f)
  (+ (* b (quotient _ (* b 10))) (min (+ (modulo _ (* b 10)) 1) b)))

(define (f n d)
  (let loop ((a n) (b 1) (acc 0))
    (let ((_ (- n (* d b))))
      (if (< _ 0)
        acc
        (loop (quotient a 10) (* b 10) (+ acc (_f))))))) 

(define-inline (_g)
  (max (quotient (abs _) (max (inexact->exact (floor (log i 10))) 1)) 1))

(define (s d)
  (let ((l (expt 10 (quotient (* 10 (+ d 19)) 9))))
    (let loop ((i 1) (acc 0))
      (if (< i l)
        (let ((_ (- (f i d) i)))
          (case (signum _)
            (( 1) (loop (+ i    _) acc))
            (( 0) (loop (+ i    1) (+ acc i)))
            ((-1) (loop (+ i (_g)) acc))))
        acc))))

(define (solve)
  (let loop ((i 1) (acc 0))
    (if (= i 10)
      acc
      (loop (+ i 1) (+ acc (s i))))))

(let ((_ (solve)))
  (print _) (assert (= _ 21295121502550)))
