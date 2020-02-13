(import euler)

(define (test-helper n op)
  (let helper ((lst (number->list n)))
    (cond ((null? (cdr lst))
           #t)
          ((op (car lst) (cadr lst))
           #f)
          (else
            (helper (cdr lst))))))

(define (increasing? n)
  (test-helper n >))

(define (decreasing? n)
  (test-helper n <))

(define (bouncy? n)
  (not (or (increasing? n)
           (decreasing? n))))

(define (main n)
  (let ((stop (/ n 100)))
    (let helper ((x 100) (b 0))
      (let ((t
              (if (bouncy? x)
                  (add1 b)
                  b)))
        (if (= (/ t x) stop)
            x
            (helper (add1 x) t))))))

(display (main 99))
(newline)
