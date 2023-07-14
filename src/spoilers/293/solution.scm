(import
  (euler)
  (srfi 69))

(define (nodes limit)
  (let loop ((i 1) (product 1))
    (if (prime? i)
      (let ((_ (* product i)))
        (if (> _ limit)
          '()
          (cons i (loop (+ i 1) _))))
      (loop (+ i 1) product))))

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
    (let loop ((i 2) (product 1))
      (let ((_ (* product i)))
        (unless (> _ limit)
          (hash-table-set! acc _ #t)
          (for-each
            (lambda (next)
              (loop next _))
            (hash-table-keys (hash-table-ref graph i))))))
    (hash-table-keys acc)))

(define (pseudo-fortunate n)
  (do ((i 2 (+ i 1)))
    ((prime? (+ n i)) i)))

(define (solve limit)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (i)
        (hash-table-set! acc (pseudo-fortunate i) #t))
      (run (graph (nodes limit)) limit))
    (apply + (hash-table-keys acc))))

(let ((_ (solve #e1e9)))
  (print _) (assert (= _ 2209)))
