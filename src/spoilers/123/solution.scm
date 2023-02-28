(import
  (euler))

(define-constant l #e5e5)

(define (f p i)
  (let ((m (* p p)))
    (modulo
      (+ (modular-expt (- p 1) i m)
         (modular-expt (+ p 1) i m))
      m)))

(define (solve n)
  (let loop ((p (primes l)) (i 1))
    (if (> (f (car p) i) n)
      i
      (loop (cdr p) (+ i 1)))))

(let ((_ (solve #e1e10)))
  (print _) (assert (= _ 21035)))
