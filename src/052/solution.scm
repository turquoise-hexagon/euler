(import
  (chicken fixnum))

(define-syntax helper!
  (syntax-rules ()
    ((_ n acc increment)
     (let loop ((n n))
       (unless (fx= n 0)
         (let ((_ (fxmod n 10)))
           (vector-set! acc _ (fx+ (vector-ref acc _) increment)))
         (loop (fx/ n 10)))))))

(define (permutation? a b)
  (let ((acc (make-vector 10 0)))
    (helper! a acc +1)
    (helper! b acc -1)
    (let loop ((i 0))
      (if (fx= i 10)
        #t
        (if (fx= (vector-ref acc i) 0)
          (loop (fx+ i 1))
          #f)))))

(define (valid? n l)
  (let loop ((i 2) (s (fx+ n n)))
    (if (fx> i l)
      #t
      (if (permutation? n s)
        (loop (fx+ i 1) (fx+ s n))
        #f))))

(define (solve l)
  (let loop ((i 1))
    (if (valid? i l)
      i
      (loop (fx+ i 1)))))

(let ((_ (solve 6)))
  (print _) (assert (= _ 142857)))
