(import
  (chicken bitwise)
  (euler)
  (srfi 69))

(define (pandigital? n)
  (let loop ((i n) (cnt 0) (acc 0))
    (if (= i 0)
      (= acc (- (arithmetic-shift 1 cnt) 1))
      (let ((tmp (bitwise-ior acc (arithmetic-shift 1 (- (modulo i 10) 1)))))
        (if (= tmp acc)
          #f
          (loop (quotient i 10) (+ cnt 1) tmp))))))

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

(print (solve))
