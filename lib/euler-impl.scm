(define (number->list n #!optional (base 10))
  (do ((x n (quotient x base))
       (acc (list) (cons (remainder x base) acc)))
    ((zero? x) acc)))

(define (list->number lst)
  (do ((lst lst (cdr lst))
       (acc 0 (+ (* acc 10) (car lst))))
    ((null? lst) acc)))

(define (prime? n)
  (cond ((<= n 1) #f)
        ((<= n 3) #t)
        ((or (zero? (remainder n 2))
             (zero? (remainder n 3)))
         #f)
        (else (let helper ((x 5))
                (cond ((> (* x x) n) #t)
                      ((or (zero? (remainder n x))
                           (zero? (remainder n (+ x 2))))
                       #f)
                      (else (helper (+ x 6))))))))

(define (palindrome? n)
  (let ((lst (number->list n)))
    (equal? lst (reverse lst))))

(define (reverse-number n)
  (do ((x n (quotient x 10))
       (acc 0 (+ (* acc 10) (remainder x 10))))
    ((zero? x) acc)))

(define (factorial n)
  (if (zero? n)
      1
      (let helper ((x 1) (acc n))
        (if (> acc x)
            (* (helper (+ x x) acc)
               (helper (+ x x) (- acc x)))
            acc))))

(define (digitsum n)
  (do ((x n (quotient x 10))
       (acc 0 (+ (remainder x 10) acc)))
    ((zero? x) acc)))

(define (sieve n)
  (let ((limit (sqrt n))
        (array (make-vector (add1 n) #t)))
    (do ((x 2 (add1 x))) ((> x limit))
      (when (vector-ref array x)
        (do ((y (* x x) (+ y x))) ((> y n))
          (vector-set! array y #f))))
    (do ((x n (sub1 x))
         (acc (list) (if (vector-ref array x)
                         (cons x acc)
                         acc)))
      ((< x 2) acc))))
