(import
  (chicken flonum)
  (chicken format)
  (chicken sort)
  (euler))

(define (make-generator)
  (set! i 290797)
  (define (generator)
    (let ((_ i))
      (set! i (modulo (* i i) 50515093))
      _))
  generator)

(define (generate n)
  (let ((generator (make-generator)))
    (let loop ((i 1) (acc '()))
      (if (> i n)
        acc
        (loop (+ i 1) (cons (list (generator) (generator)) acc))))))

(define (distance a b)
  (sqrt
    (apply +
      (map
        (lambda (i)
          (* i i))
        (map - a b)))))

(define (solve n)
  (let ((l (map car
             (sort
               (map
                 (lambda (i)
                   (cons i (distance i '(0 0))))
                 (generate n))
               (lambda (a b)
                 (< (cdr a)
                    (cdr b)))))))
    (foldl min +inf.0 (map distance l (cdr l)))))

(define (output n)
  (flonum-print-precision 11) (format "~a" n))

(let ((_ (output (solve #e2e6))))
  (print _) (assert (string=? _ "20.880613018")))
