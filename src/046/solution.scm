(import
  (euler)
  (srfi 69))

(define limit 5000)

(define (generate)
  (let ((acc (make-hash-table)) (lst (range 0 limit)))
    (for-each
      (lambda (p)
        (for-each (lambda (_) (hash-table-set! acc (+ p (* 2 _ _)) #t)) lst))
      (primes limit))
    acc))

(define (solve)
  (let ((table (generate)))
    (let loop ((i 3))
      (if (hash-table-exists? table i)
        (loop (+ i 2))
        i))))

(let ((_ (solve)))
  (print _) (assert (= _ 5777)))
