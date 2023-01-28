(import
  (chicken fixnum)
  (euler))

(define-syntax f
  (syntax-rules ()
    ((_ a b n)
     (fx+ (fx+ (fx* n n)
               (fx* a n))
          b))))

(define (make-number-primes n)
  (let* ((l (f n n n)) (acc (make-vector l #f)))
    (for-each
      (lambda (p)
        (vector-set! acc p #t))
      (primes l))
    (define (number-primes a b)
      (let loop ((n 0))
        (let ((_ (f a b n)))
          (if (and (fx>= _ 0) (vector-ref acc _))
            (loop (fx+ n 1))
            (fx- n 1)))))
    number-primes))

(define (solve n)
  (let ((number-primes (make-number-primes n)))
    (let loop ((a (fxneg n)) (tmp 0) (acc 0))
      (if (fx> a n)
        acc
        (let subloop ((b (fxneg n)) (tmp tmp) (acc acc))
          (if (fx> b n)
            (loop (fx+ a 1) tmp acc)
            (let ((_ (number-primes a b)))
              (if (fx> _ tmp)
                (subloop (fx+ b 1) _ (fx* a b))
                (subloop (fx+ b 1) tmp acc)))))))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ -59231)))
