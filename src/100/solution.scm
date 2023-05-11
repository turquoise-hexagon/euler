(import
  (srfi 69))

(define (next n)
  (apply
    (lambda (a b)
      (list (+ (* 5 a) (* 2 b) -2)
            (+ (* 2 a) (* 1 b) -1)))
    (function (- n 1))))

(define function
  (let ((cache (make-hash-table)))
    (hash-table-set! cache 0 '(1 0))
    (lambda (n)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let ((acc (next n)))
          (hash-table-set! cache n acc)
          acc)))))

(define (solve limit)
  (let loop ((i 1))
    (let ((_ (function i)))
      (if (> (apply + _) limit)
        (car _)
        (loop (+ i 1))))))

(let ((_ (solve #e1e12)))
  (print _) (assert (= _ 756872327473)))
