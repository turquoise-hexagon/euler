(import
  (chicken fixnum)
  (chicken sort)
  (euler))

(define (make-radical n)
  (let ((acc (make-vector (fx+ n 1) 1)))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m n)
            (vector-set! acc m (fx* (vector-ref acc m) p))
            (loop (fx+ m p)))))
      (primes n))
    (define (radical n)
      (vector-ref acc n))
    radical))

(define (solve n i)
  (let ((acc (make-vector (fx+ n 1) 0)) (radical (make-radical n)))
    (let loop ((i 0))
      (unless (fx> i n)
        (vector-set! acc i i)
        (loop (fx+ i 1))))
    (vector-ref
      (sort acc
        (lambda (a b)
          (fx< (radical a)
               (radical b))))
      i)))

(let ((_ (solve #e1e5 #e1e4)))
  (print _) (assert (= _ 21417)))
