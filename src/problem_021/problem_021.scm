(import
  (euler))

(define (sieve n)
  (let ((sieve (make-vector (+ n 1) 0)))
    (do ((i 1 (+ i 1))) ((> i n))
      (do ((j (+ i i) (+ j i))) ((> j n))
        (vector-set! sieve j (+ (vector-ref sieve j) i))))
    sieve))

(define (solve n)
  (let ((sieve (sieve n)))
    (foldl
      (lambda (acc i)
        (let ((tmp (vector-ref sieve i)))
          (if (and (> n tmp) (not (= i tmp)) (= (vector-ref sieve tmp) i))
            (+ acc tmp)
            acc)))
      0 (range 1 n))))

(print (solve 10000))
