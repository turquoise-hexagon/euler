(import
  (euler))

(define-constant primes-limit   #e1e7)
(define-constant generate-limit #e1e8)

(define (generate b e)
  (priority-queue-take
    (foldl
      (lambda (acc p)
        (let loop ((k 0) (acc acc))
          (let ((_ (expt p (expt b k))))
            (if (> _ generate-limit)
              acc
              (loop (+ k 1) (priority-queue-insert acc _))))))
      (priority-queue <) (primes primes-limit))
    e))

(define (solve b e m)
  (modular-expt
    (priority-queue-fold (generate b e)
      (lambda (acc i)
        (modulo (* acc i) m))
      1)
    (- b 1)
    m))

(let ((_ (solve 2 500500 500500507)))
  (print _) (assert (= _ 35407281)))
