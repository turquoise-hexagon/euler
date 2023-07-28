(import
  (chicken fixnum))

(define-constant limit 28123)

(define (make-sum-divisors limit)
  (let ((acc (make-vector (fx+ limit 1) 0)))
    (do ((i 1 (fx+ i 1))) ((fx> i limit))
      (do ((j (fx+ i i) (fx+ j i))) ((fx> j limit))
        (vector-set! acc j (fx+ (vector-ref acc j) i))))
    (lambda (n)
      (vector-ref acc n))))

(define (abundants limit)
  (let ((sum-divisors (make-sum-divisors limit)))
    (do ((i 0 (fx+ i 1))
         (acc '() (if (fx> (sum-divisors i) i)
                    (cons i acc)
                    acc)))
      ((fx> i limit) acc))))

(define (make-valid? limit)
  (let ((acc (make-vector (fx+ limit 1) #t)))
    (let loop ((lst (abundants limit)))
      (unless (null? lst)
        (let ((a (car lst)))
          (for-each
            (lambda (b)
              (let ((_ (fx+ a b)))
                (unless (fx> _ limit)
                  (vector-set! acc _ #f))))
            lst))
        (loop (cdr lst))))
    (lambda (n)
      (vector-ref acc n))))

(define (solve)
  (let ((valid? (make-valid? limit)))
    (do ((i 0 (fx+ i 1))
         (acc 0 (if (valid? i)
                  (fx+ acc i)
                  acc)))
      ((fx> i limit) acc))))

(let ((_ (solve)))
  (print _) (assert (= _ 4179871)))
