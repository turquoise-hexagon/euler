(define (next n)
  (+ (*  3 (function (- n 1)))
     (*  3 (function (- n 2)))
     (* -1 (function (- n 3)))))

(define function
  (let ((cache (make-vector 100 #f)))
    (vector-set! cache 0 1)
    (vector-set! cache 1 1)
    (vector-set! cache 2 5)
    (lambda (n)
      (let ((acc (vector-ref cache n)))
        (if (number? acc)
          acc
          (let ((acc (next n)))
            (vector-set! cache n acc)
            acc))))))

(define (area a b c)
  (let ((t (/ (+ a b c) 2)))
    (sqrt (* (- t a)
             (- t b)
             (- t c)
             t))))

(define (solve limit)
  (let loop ((i 2) (acc 0))
    (let ((t (function i)))
      (if (> (+ t t (- t 1)) limit)
        acc
        (loop (+ i 1)
          (cond
            ((integer? (area t t (- t 1)))
             (+ acc t t (- t 1)))
            ((integer? (area t t (+ t 1)))
             (+ acc t t (+ t 1)))
            (else acc)))))))

(let ((_ (solve #e1e9)))
  (print _) (assert (= _ 518408346)))
