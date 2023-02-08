(import
  (chicken fixnum))

(define (make-divisors n)
  (let ((acc (make-vector (fx+ n 1) '(1))))
    (do ((i 2 (fx+ i 1))) ((fx> i n))
      (do ((m i (fx+ m i))) ((fx> m n))
        (vector-set! acc m (cons i (vector-ref acc m)))))
    (define (divisors n)
      (vector-ref acc n))
    divisors))

(define (solve n)
  (let ((mem (make-vector (fx+ n 1) 1)) (divisors (make-divisors n)))
    (do ((i 2 (fx+ i 1))) ((fx> i n))
      (let ((a (divisors (fx- i 1))) (b (divisors i)))
        (for-each
          (lambda (a)
            (for-each
              (lambda (b)
                (let ((k (fx* a b)))
                  (when (and (fx<= k n)
                             (fx<  i k)
                             (fx>  i (vector-ref mem k)))
                    (vector-set! mem k i))))
              b))
          a)))
    (do ((i 2 (fx+ i 1))
         (acc 0 (fx+ acc (vector-ref mem i))))
      ((fx> i n) acc))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 39782849136421)))
