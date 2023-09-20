(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define (fxlcm a b)
  (fx/ (fx* a b) (fxgcd a b)))

(define (bruteforce n)
  (let loop ((acc 1) (a 1) (b 1))
    (if (and (fx= a 0)
             (fx= b 1))
      acc
      (loop (fx+ acc 1) b (fxmod (fx+ a b) n)))))

(define (finesse n factors)
  (foldl
    (lambda (acc i)
      (apply
        (lambda (e p)
          (fxlcm acc (pisano (fxexpt p e))))
        i))
    1 factors))

(define (pi n)
  (if (fx= n 1)
    1
    (let ((factors (run-length (factors n) fx=)))
      (if (null? (cdr factors))
        (bruteforce n)
        (finesse n factors)))))

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
