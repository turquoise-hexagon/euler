(import
  (chicken fixnum)
  (euler))

(define (make-phi limit)
  (let ((acc (make-vector (fx+ limit 1))))
    (do ((i 0 (fx+ i 1))) ((fx> i limit))
      (vector-set! acc i i))
    (for-each
      (lambda (i)
        (do ((j i (fx+ j i))) ((fx> j limit))
          (let ((_ (vector-ref acc j)))
            (vector-set! acc j (fx- _ (fx/ _ i))))))
      (primes limit))
    (lambda (n)
      (vector-ref acc n))))

(define-inline (helper! vec n i)
  (do ((n n (fx/ n 10))) ((fx= n 0))
    (let ((_ (fxmod n 10)))
      (vector-set! acc _ (fx+ (vector-ref acc _) i)))))

(define (permutation? a b)
  (let ((acc (make-vector 10 0)))
    (helper! acc a +1)
    (helper! acc b -1)
    (let loop ((i 0))
      (if (fx= i 10)
        #t
        (if (fx= (vector-ref acc i) 0)
          (loop (fx+ i 1))
          #f)))))

(define (solve limit)
  (let ((phi (make-phi limit)))
    (let loop ((i 2) (res +inf.0) (acc 0))
      (if (fx> i limit)
        acc
        (let ((_ (phi i)))
          (if (permutation? i _)
            (let ((_ (/ i _)))
              (if (< _ res)
                (loop (fx+ i 1) _ i)
                (loop (fx+ i 1) res acc)))
            (loop (fx+ i 1) res acc)))))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 8319823)))
