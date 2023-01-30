(import
  (chicken fixnum)
  (euler))

(define (make-prime? n)
  (let ((acc (make-vector (fx+ n 1) #f)))
    (for-each
      (lambda (_)
        (vector-set! acc _ #t))
      (primes n))
    (define (prime? n)
      (vector-ref acc n))
    prime?))

(define (solve n)
  (let ((prime? (make-prime? n)))
    (let loop ((i 2) (acc 0))
      (if (fx> (fx* i i) n)
        acc
        (loop (fx+ i 1)
          (let loop ((j 1) (acc acc))
            (let ((a (fx- (fx* j (fx* i i)) 1)))
              (if (fx> a n)
                acc
                (loop (fx+ j 1)
                  (if (prime? a)
                    (let loop ((k 1) (acc acc))
                      (if (fx> k i)
                        acc
                        (loop (fx+ k 1)
                          (if (fx= (fxgcd i k) 1)
                            (let ((b (fx- (fx* j (fx* i k)) 1))
                                  (c (fx- (fx* j (fx* k k)) 1)))
                              (if (and (prime? b)
                                       (prime? c))
                                (fx+ acc (fx+ a (fx+ b c)))
                                acc))
                            acc))))
                    acc))))))))))

(let ((_ (solve #e1e8)))
  (print _) (assert (= _ 100315739184392)))
