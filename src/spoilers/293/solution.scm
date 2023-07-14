(import
  (euler)
  (srfi 69))

(define (primes-limit limit)
  (let loop ((i 1) (acc 1))
    (if (prime? i)
      (let ((_ (* acc i)))
        (if (> _ limit)
          '()
          (cons i (loop (+ i 1) _))))
      (loop (+ i 1) acc))))

(define (connect! graph a b)
  (let ((value (hash-table-ref/default graph a (make-hash-table))))
    (hash-table-set! value b #t)
    (hash-table-set! graph a value)))

(define (graph primes)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (a b)
        (connect! acc a a)
        (connect! acc b b)
        (connect! acc a b))
      primes (cdr primes))
    acc))

(define (run graph limit)
  (let ((acc (make-hash-table)))
    (let loop ((current 2) (product 1))
      (let ((_ (* product current)))
        (unless (> _ limit)
          (hash-table-set! acc _ #t)
          (for-each
            (lambda (next)
              (loop next _))
            (hash-table-keys (hash-table-ref graph current))))))
    (hash-table-keys acc)))

(define (pseudo-fortunate n)
  (do ((m 2 (+ m 1)))
    ((prime? (+ n m)) m)))

(define (solve limit)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (i)
        (hash-table-set! acc (pseudo-fortunate i) #t))
      (run (graph (primes-limit limit)) limit))
    (apply + (hash-table-keys acc))))

(let ((_ (solve #e1e9)))
  (print _) (assert (= _ 2209)))
