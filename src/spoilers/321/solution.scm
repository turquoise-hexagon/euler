(import
  (srfi 69))

(define (next/1 function n)
  (apply
    (lambda (a b)
      (list (+ (* 3 a) (* 2 b) 3)
            (+ (* 4 a) (* 3 b) 5)))
    (function (- n 1))))

(define (next/2 function n)
  (apply
    (lambda (a b)
      (list (+ (*  3 a) (* -2 b)  1)
            (+ (* -4 a) (*  3 b) -3)))
    (function (- n 1))))

(define (make-function init/indexes init/values next)
  (let ((cache (make-hash-table)))
    (for-each
      (lambda (index value)
        (hash-table-set! cache index value))
      init/indexes init/values)
    (define (function n)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let ((acc (next function n)))
          (hash-table-set! cache n acc)
          acc)))))

(define (solve limit)
  (let ((function/1 (make-function '(0) '((0 0)) next/1))
        (function/2 (make-function '(0) '((0 0)) next/2)))
    (do ((i 0 (+ i 1))
         (acc 0 (let ((_ (quotient (+ i 1) 2)))
                  (if (even? i)
                    (+ acc (car (function/1 _)))
                    (+ acc (car (function/2 _)))))))
      ((> i limit) acc))))

(let ((_ (solve 40)))
  (print _) (assert (= _ 2470433131948040)))
