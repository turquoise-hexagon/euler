(import
  (chicken fixnum)
  (euler))

(define (roots n)
  (let ((_ (- n 1)))
    (if (= (modulo n 3) 1)
      (let loop ((i 2))
        (let ((x (modular-expt i (quotient _ 3) n)))
          (if (= x 1)
            (loop (+ i 1))
            (list (- n x) (modulo (- (* x x)) n) _))))
      (list _))))

(define (solve l)
  (let ((mem (make-vector (+ l 1))))
    (do ((i 0 (+ i 1))) ((> i l))
      (vector-set! mem i (+ (expt i 3) 1)))
    (for-each
      (lambda (i)
        (for-each
          (lambda (j)
            (do ((k j (+ k i))) ((> k l))
              (do ((x (vector-ref mem k) (quotient x i)))
                ((not (and (> x i) (zero? (modulo x i))))
                 (vector-set! mem k x)))))
          (roots i)))
      (primes (+ l 1)))
    (do ((i 0 (+ i 1))
         (acc 0 (+ acc (vector-ref mem i))))
      ((> i l) (- acc l 1)))))

(let ((_ (solve #e2e6)))
  (print _) (assert (= _ 269533451414884183)))
