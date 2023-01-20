(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define-syntax f
  (syntax-rules ()
    ((_ a b n)
     (fx+ (fx+ (fx* n n)
               (fx* a n))
          b))))

(define (make-number-primes n)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (p)
        (hash-table-set! acc p #t))
      (primes (f n n n)))
    (define (number-primes a b)
      (let loop ((n 0))
        (if (hash-table-exists? acc (f a b n))
          (loop (fx+ n 1))
          (fx- n 1))))
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
