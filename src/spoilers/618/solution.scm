(import
  (chicken fixnum)
  (euler))

(define (make-S l m)
  (let* ((n (fibonacci l)) (acc (make-vector (fx+ n 1) 0)))
    (define (_ n)
      (vector-ref acc n))
    (vector-set! acc 0 1)
    (for-each
      (lambda (p)
        (do ((i p (fx+ i 1))) ((fx> i n))
          (vector-set! acc i (fxmod (fx+ (_ i) (fx* p (_ (fx- i p)))) m))))
      (primes n))
    _))

(define (solve l m)
  (let ((S (make-S l m)))
    (let loop ((i 1) (acc 0))
      (if (fx> i l)
        acc
        (loop (fx+ i 1) (fxmod (fx+ acc (S (fibonacci i))) m))))))

(let ((_ (solve 24 #e1e9)))
  (print _) (assert (= _ 634212216)))
