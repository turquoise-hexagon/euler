(import
  (euler))

(define (factorial-mod n m)
  (let loop ((i (- m 1)) (acc (- m 1)))
    (if (> i n)
      (loop (- i 1) (modulo (* acc (modular-inverse i m)) m))
      acc)))

(define (solve n)
  (foldl
    (lambda (acc i)
      (let* ((a (factorial-mod (- i 5) i))
             (b (modulo (* a (- i 4)) i))
             (c (modulo (* b (- i 3)) i))
             (d (modulo (* c (- i 2)) i))
             (e (- i 1)))
        (+ acc (modulo (+ a b c d e) i))))
    0 (list-tail (primes n) 2)))

(let ((_ (solve #e1e8)))
  (print _) (assert (= _ 139602943319822)))
