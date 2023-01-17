(import
  (chicken sort)
  (chicken flonum)
  (chicken format))

(define (make-generator)
  (set! i 290797)
  (lambda ()
    (let ((_ i))
      (set! i (modulo (* i i) 50515093))
      _)))

(define (generate limit)
  (let ((generator (make-generator)))
    (let loop ((i 1) (acc '()))
      (if (> i limit)
        acc
        (loop (+ i 1)
          (let ((_ (list (generator) (generator))))
            (cons _ acc)))))))

(define (distance a b)
  (sqrt
    (apply +
      (map
        (lambda (_)
          (* _ _))
        (map - a b)))))

(define (solve limit)
  (let ((_
          (map car
            (sort
              (map
                (lambda (_)
                  (cons _ (distance _ '(0 0))))
                (generate limit))
              (lambda (a b)
                (< (cdr a)
                   (cdr b)))))))
    (foldl min +inf.0 (map distance _ (cdr _)))))

(define (output n)
  (flonum-print-precision 11) (format "~a" n))

(let ((_ (output (solve #e2e6))))
  (print _) (assert (string=? _ "20.880613018")))
