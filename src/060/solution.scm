(import
  (euler)
  (only (srfi 1)
    filter
    every))

(define (concatenate a b)
  (let loop ((i b) (a a))
    (if (= i 0)
      (+ a b)
      (loop (quotient i 10) (* a 10)))))

(define (group acc primes)
  (foldl
    (lambda (acc prime)
      (map
        (lambda (group)
          (if (every
                (lambda (i)
                  (and (prime? (concatenate prime i))
                       (prime? (concatenate i prime))))
                group)
            (cons prime group)
            group))
        acc))
    acc primes))

(define (solve n)
  (let ((primes (primes 10000)))
    (let loop ((acc (map list primes)))
      (let ((tmp (group acc primes)))
        (if (equal? tmp acc)
          (apply min
            (map
              (lambda (group)
                (apply + group))
              (filter
                (lambda (group)
                  (= (length group) n))
                acc)))
          (loop tmp))))))

(let ((_ (solve 5)))
  (print _) (assert (= _ 26033)))
