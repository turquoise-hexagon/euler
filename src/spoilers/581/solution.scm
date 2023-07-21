(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define-constant product-limit #e2e12)

(define (generate primes-limit product-limit)
  (let ((acc (make-hash-table)))
    (let loop ((i 1) (l (primes primes-limit)))
      (unless (fx> i product-limit)
        (hash-table-set! acc i #t)
        (let subloop ((l l))
          (unless (null? l)
            (loop (fx* i (car l)) l)
            (subloop (cdr l))))))
    acc))

(define (solve primes-limit)
  (let ((table (generate primes-limit product-limit)))
    (foldl
      (lambda (acc i)
        (if (hash-table-exists? table (fx+ i 1))
          (fx+ acc i)
          acc))
      0 (hash-table-keys table))))

(let ((_ (solve 47)))
  (print _) (assert (= _ 2227616372734)))
