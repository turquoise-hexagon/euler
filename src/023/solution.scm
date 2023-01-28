(import
  (chicken fixnum))

(define-constant limit 28123)

(define (make-sum-divisors n)
  (let ((acc (make-vector (fx+ n 1) 0)))
    (do ((i 1 (fx+ i 1))) ((fx> i n))
      (do ((m (fx+ i i) (fx+ m i))) ((fx> m n))
        (vector-set! acc m (fx+ (vector-ref acc m) i))))
    (define (sum-divisors n)
      (vector-ref acc n))
    sum-divisors))

(define (abundants n)
  (let ((sum-divisors (make-sum-divisors n)))
    (do ((i 0 (fx+ i 1))
         (acc '() (if (fx> (sum-divisors i) i)
                    (cons i acc)
                    acc)))
      ((fx> i n) acc))))

(define (make-valid? n)
  (let ((acc (make-vector (fx+ n 1) #t)) (lst (abundants n)))
    (for-each
      (lambda (i)
        (for-each
          (lambda (j)
            (let ((_ (fx+ i j)))
              (unless (fx> _ n)
                (vector-set! acc _ #f))))
          lst))
      lst)
    (define (valid? n)
      (vector-ref acc n))
    valid?))

(define (solve)
  (let ((valid? (make-valid? limit)))
    (do ((i 0 (fx+ i 1))
         (acc 0 (if (valid? i)
                  (fx+ i acc)
                  acc)))
      ((fx> i limit) acc))))

(let ((_ (solve)))
  (print _) (assert (= _ 4179871)))
