(define-constant m 123)

(define-constant ln_2  (log 2))
(define-constant ln_5  (log 5))
(define-constant ln_10 (log 10))

(define (exact n)
  (inexact->exact (floor n)))

(define (valid? n)
  (= (exact (exp (+ (* ln_2 (+ (- n (exact (/ (* n ln_2) ln_10))) 2))
                    (* ln_5 (+ (- 2 (exact (/ (* n ln_2) ln_10))) 0)))))
     m))

(define (solve n)
  (let loop ((i (do ((i 0 (+ i 1))) ((valid? i) i))) (c 1))
    (if (= c n)
      i
      (loop
        (cond
          ((valid? (+ i 196)) (+ i 196))
          ((valid? (+ i 289)) (+ i 289))
          ((valid? (+ i 485)) (+ i 485)))
        (+ c 1)))))

(let ((_ (solve 678910)))
  (print _) (assert (= _ 193060223)))
