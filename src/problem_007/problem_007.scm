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
  (let loop ((x (expt a 0.85)) (cnt 0))
    (if (= cnt 10) (inexact->exact (round x))
      (loop (f-newton x a) (+ cnt 1)))))

(define (solve n)
  (list-ref (primes (f-inverse n)) n))

(print (solve 10000))
