(import
  (srfi 1))

(define-constant init '(0 1 5 9 15 21 25 29 35 39 43 55 59 63))

(define function
  (let ((cache (make-vector #e1e6)))
    (for-each
      (lambda (index value)
        (vector-set! cache index value))
      (iota (length init)) init)
    (lambda (n)
      (let ((acc (vector-ref cache n)))
        (if (number? acc)
          acc
          (let ((acc (+ (function (- n 5)) 34)))
            (vector-set! cache n acc)
            acc))))))

(define (solve n)
  (do ((i 1 (+ i 1)))
    ((> (function i) n)
     (+ (- n i) 1))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 852938)))
