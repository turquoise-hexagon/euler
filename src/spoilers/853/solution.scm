(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define (pi n)
  (if (fx= n 1)
    1
    (let loop ((acc 1) (a 1) (b 1))
      (if (and (fx= a 0)
               (fx= b 1))
        acc
        (loop (fx+ acc 1) b (fxmod (fx+ a b) n))))))

(define pisano
  (let ((cache (make-hash-table)))
    (lambda (n)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let ((acc (pi n)))
          (hash-table-set! cache n acc)
          acc)))))

(define (solve limit target)
  (foldl
    (lambda (acc i)
      (if (fx> i limit)
        acc
        (if (fx= (pisano i) target)
          (fx+ acc i)
          acc)))
    0 (divisors (fibonacci target))))

(let ((_ (solve #e1e9 120)))
  (print _) (assert (= _ 44511058204)))
