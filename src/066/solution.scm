(import
  (euler))

(define // quotient)

(define (solve-pell n)
  (let ((x (inexact->exact (floor (sqrt n)))))
    (if (= (* x x) n)
      '(1 . 0)
      (let loop ((y x) (z 1) (r (* 2 x)) (e '(1 . 0)) (f '(0 . 1)) (a 0) (b 0))
        (let* ((y (- (* r z) y))
               (z (// (- n (* y y)) z))
               (r (// (+ x y) z))
               (e (cons (cdr e) (+ (* r (cdr e)) (car e))))
               (f (cons (cdr f) (+ (* r (cdr f)) (car f))))
               (a (+ (cdr e) (* x (cdr f))))
               (b (cdr f)))
          (if (= (- (* a a) (* n b b)) 1)
            (cons a b)
            (loop y z r e f a b)))))))

(define (solve n)
  (extremum (range 1 n) (lambda (_) (car (solve-pell _))) >))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 661)))
