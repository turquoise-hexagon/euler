(import
  (euler)
  (srfi 69)
  (only
    (srfi 1)
    every
    filter))

(define-constant LIMIT #e1e4)

(define (concatenate a b)
  (let loop ((i b) (a a))
    (if (= i 0)
      (+ a b)
      (loop (quotient i 10) (* a 10)))))

(define (make-prime? n)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (_)
        (hash-table-set! acc _ #t))
      (primes n))
    (define (prime? n)
      (hash-table-exists? acc n))
    prime?))

(define (make-group n)
  (let ((prime? (make-prime? (* n n))))
    (define (group lst primes)
      (foldl
        (lambda (acc p)
          (map
            (lambda (group)
              (if (every
                    (lambda (i)
                      (and
                        (prime? (concatenate i p))
                        (prime? (concatenate p i))))
                    group)
                (cons p group)
                group))
            acc))
        lst primes))
    group))

(define (solve n)
  (let ((primes (primes LIMIT)) (group (make-group LIMIT)))
    (let loop ((acc (map list primes)))
      (let ((_ (group acc primes)))
        (if (equal? _ acc)
          (apply min
            (map
              (lambda (group)
                (apply + group))
              (filter
                (lambda (group)
                  (= (length group) n))
                acc)))
          (loop _))))))

(let ((_ (solve 5)))
  (print _) (assert (= _ 26033)))
