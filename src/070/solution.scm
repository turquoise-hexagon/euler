(import
  (euler))

(define (factors n)
  (let ((acc (make-vector (+ n 1) '())))
    (for-each
      (lambda (p)
        (do ((m p (+ m p))) ((> m n))
          (let ((_ (vector-ref acc m)))
            (vector-set! acc m (cons p _)))))
      (primes n))
    acc))

(define (make-phi n)
  (let ((factors (factors n)))
    (lambda (n)
      (foldl * n
        (map
          (lambda (_)
            (- 1 (/ 1 _)))
          (vector-ref factors n))))))

(define-syntax helper!
  (syntax-rules ()
    ((_ vec n increment)
     (let loop ((i n))
       (unless (= i 0)
         (let ((q (quotient i 10)) (m (modulo i 10)))
           (vector-set! vec m (+ (vector-ref vec m) increment))
           (loop q)))))))

(define (permutation? a b)
  (let ((acc (make-vector 10 0)))
    (helper! acc a +1)
    (helper! acc b -1)
    (let loop ((i 0))
      (if (= i 10)
        #t
        (if (= (vector-ref acc i) 0)
          (loop (+ i 1))
          #f)))))

(define (solve n)
  (let ((phi (make-phi n)))
    (let loop ((i 2) (ratio +inf.0) (acc 0))
      (if (> i n)
        acc
        (let ((_ (phi i)))
          (if (permutation? i _)
            (let ((_ (/ i _)))
              (if (< _ ratio)
                (loop (+ i 1) _ i)
                (loop (+ i 1) ratio acc)))
            (loop (+ i 1) ratio acc)))))))

(print (solve 10000000))
