(import
  (euler))

(define (binomial m n)
  (if (< m n) 0 (/ (factorial m) (* (factorial n) (factorial (- m n))))))

(define-inline (_lucas m n p)
  (let loop ((m m) (n n) (acc 1))
    (if (and (= m 0)
             (= n 0))
      acc
      (loop
        (quotient m p)
        (quotient n p)
        (modulo
          (* acc
             (binomial
               (modulo m p)
               (modulo n p)))
          p)))))

(define (make-lucas m n primes limit)
  (let ((acc (make-vector (+ limit 1))))
    (for-each
      (lambda (p)
        (vector-set! acc p (_lucas m n p)))
      primes)
    (define (lucas p)
      (vector-ref acc p))
    lucas))

(define (generate a b)
  (let loop ((lst (primes b)))
    (if (> (car lst) a)
      lst
      (loop (cdr lst)))))

(define-inline (_solve a b c lucas)
  (let ((i (lucas a))
        (j (lucas b))
        (k (lucas c)))
    (if (and (= i 0)
             (= j 0)
             (= k 0))
      0
      (solve-chinese
        (list i j k)
        (list a b c)))))

(define (solve m n a b)
  (let* ((primes (generate a b)) (lucas (make-lucas m n primes b)))
    (do ((a primes (cdr a))
         (s 0 (do ((b (cdr a) (cdr b))
                   (s s (do ((c (cdr b) (cdr c))
                             (s s (+ s (_solve (car a) (car b) (car c) lucas))))
                          ((null? c) s))))
                ((null? b) s))))
      ((null? a) s))))

(let ((_ (solve #e1e18 #e1e9 1000 5000)))
  (print _) (assert (= _ 162619462356610313)))
