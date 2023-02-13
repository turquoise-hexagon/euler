(import
  (chicken bitwise)
  (euler)
  (srfi 69))

(define (pandigital? n)
  (if (= n 0)
    #f
    (let loop ((n n) (c 0) (d 0))
      (if (= n 0)
        (= d (- (arithmetic-shift 1 c) 1))
        (let ((t (bitwise-ior d (arithmetic-shift 1 (- (modulo n 10) 1)))))
          (if (= d t)
            #f
            (loop (quotient n 10) (+ c 1) t)))))))

(define (concatenate a b)
  (let loop ((i b) (a a))
    (if (= i 0)
      (+ a b)
      (loop (quotient i 10) (* a 10)))))

(define (helper! cache a/min a/max b/min b/max)
  (let ((a (range a/min a/max))
        (b (range b/min b/max)))
    (for-each
      (lambda (a)
        (for-each
          (lambda (b)
            (let ((_ (* a b)))
              (when (pandigital? (concatenate a (concatenate b _)))
                (hash-table-set! cache _ #t))))
          b))
      a)))

(define (solve)
  (let ((acc (make-hash-table)))
    #|
    9 digits =>
    - either 2 digits * 3 digits
    - either 1 digits * 4 digits
    |#
    (helper! acc 10 99 100 999)
    (helper! acc 1 9 1000 9999)
    (apply + (hash-table-keys acc))))

(let ((_ (solve)))
  (print _) (assert (= _ 45228)))
