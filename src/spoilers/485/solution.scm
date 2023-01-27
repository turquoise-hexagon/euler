(import
  (chicken fixnum)
  (euler))

(define (make-number-divisors n)
  (let ((acc (make-vector (fx+ n 1) 1)))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m n)
            (let subloop ((i m) (tmp 0))
              (if (fx= (fxmod i p) 0)
                (subloop (fx/ i p) (fx+ tmp 1))
                (vector-set! acc m (fx* (vector-ref acc m) (fx+ tmp 1)))))
            (loop (fx+ m p)))))
      (primes n))
    (define (number-divisors n)
      (vector-ref acc n))
    number-divisors))

(define (make-maximum-value n)
  (let ((cache (make-vector (fx+ n 1) 0)) (number-divisors (make-number-divisors n)))

    (define (bruteforce n k)
      (let ((l (fx- (fx+ n k) 1)))
        (let loop ((i n) (acc 0))
          (if (fx> i l)
            acc
            (loop (fx+ i 1) (fxmax acc (number-divisors i)))))))

    (define (memoized n k)
      (let ((l (fx- (fx+ n k) 1)) (p (fx- n 1)))
        (if (fx< i 0)
          (bruteforce n k)
          (let ((c (vector-ref cache p)))
            (if (fx> c 0)
              (if (and (fx= (number-divisors p) c)
                       (fx< (number-divisors l) c))
                (bruteforce n k)
                (fxmax c (number-divisors l)))
              (bruteforce n k))))))

    (define (maximum-value n k)
      (let ((acc (memoized n k)))
        (vector-set! cache n acc)
        acc))

    maximum-value))

(define (solve u k)
  (let ((l (fx+ (fx- u k) 1)) (maximum-value (make-maximum-value u)))
    (let loop ((i 1) (acc 0))
      (if (fx> i l)
        acc
        (loop (fx+ i 1) (fx+ acc (maximum-value i k)))))))

(let ((_ (solve #e1e8 #e1e5)))
  (print _) (assert (= _ 51281274340)))
