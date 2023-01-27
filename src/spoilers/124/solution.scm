(import
  (chicken fixnum)
  (chicken sort)
  (euler))

(define (solve n i)
  (let ((acc/1 (make-vector (fx+ n 1) 1))
        (acc/2 (make-vector (fx+ n 1) 0)))
    (let loop ((i 0))
      (unless (fx> i n)
        (vector-set! acc/2 i i)
        (loop (fx+ i 1))))
    (for-each
      (lambda (p)
        (let loop ((m p))
          (unless (fx> m n)
            (vector-set! acc/1 m (fx* (vector-ref acc/1 m) p))
            (loop (fx+ m p)))))
      (primes n))
    (vector-ref
      (sort acc/2
        (lambda (a b)
          (fx<
            (vector-ref acc/1 a)
            (vector-ref acc/1 b))))
      i)))

(let ((_ (solve #e1e5 #e1e4)))
  (print _) (assert (= _ 21417)))
