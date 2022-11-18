(import
  (euler))

(define (f x a)
  (- (/ x (log x)) a))

(define (f-derivative x)
  (/ (- (log x) 1) (expt (log x) 2)))

(define (f-newton x a)
  (- x (/ (f x a) (f-derivative x))))

(define (f-inverse a)
  ;; n / log(x) ~ n^0.85
  (let loop ((x (expt a 0.85)))
    (let ((_ (f-newton x a)))
      (if (= x _)
        (inexact->exact (round x))
        (loop _)))))

(define (solve n)
  (list-ref (primes (f-inverse n)) n))

(print (solve 10000))
