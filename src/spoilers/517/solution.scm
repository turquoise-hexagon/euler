(import
  (euler))

(define (exact n)
  (inexact->exact (floor n)))

(define (make-factorial n p)
  (let loop ((acc (make-vector (+ n 1))))
    (vector-set! acc 0 1)
    (do ((i 1 (+ i 1))) ((> i n))
      (vector-set! acc i (modulo (* (vector-ref acc (- i 1)) i) p)))
    (define (factorial n)
      (vector-ref acc n))
    factorial))

(define (make-binomial n p)
  (let ((factorial (make-factorial n p)))
    (define (binomial n k)
      (if (< n k)
        0
        (let ((a (factorial n))
              (b (factorial k))
              (c (factorial (- n k))))
          (modulo (* a (modular-inverse (modulo (* b c) p) p)) p))))
    binomial))

(define (make-function n p)
  (let ((binomial (make-binomial n p)))
    (define (function a x)
      (let ((l (exact (/ x a))))
        (let loop ((i 0) (acc 0))
          (if (> i l)
            acc
            (loop (+ i 1) (modulo (+ acc (binomial (exact (- x (* (- a 1) i))) i)) p))))))
    function))

(define (generate a b)
  (let loop ((i a) (acc '()))
    (if (> i b)
      acc
      (loop (+ i 1)
        (if (prime? i)
          (cons i acc)
          acc)))))

(define (solve a b p)
  (let ((function (make-function b p)))
    (foldl
      (lambda (acc i)
        (modulo (+ acc (function (sqrt i) i)) p))
      0 (generate a b))))

(let ((_ (solve 10000000 10010000 1000000007)))
  (print _) (assert (= _ 581468882)))
