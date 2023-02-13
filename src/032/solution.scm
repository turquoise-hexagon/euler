(import
  (chicken fixnum)
  (srfi 69))

(define (pandigital? n)
  (if (fx= n 0)
    #f
    (let loop ((n n) (c 0) (d 0))
      (if (fx= n 0)
        (fx= d (fx- (fxshl 1 c) 1))
        (let ((t (fxior d (fxshl 1 (fx- (fxmod n 10) 1)))))
          (if (fx= d t)
            #f
            (loop (fx/ n 10) (fx+ c 1) t)))))))

(define (concatenate a b)
  (let loop ((i b) (a a))
    (if (fx= i 0)
      (fx+ a b)
      (loop (fx/ i 10) (fx* a 10)))))

(define (helper! cache a/min a/max b/min b/max)
  (do ((a a/min (fx+ a 1))) ((fx> a a/max))
    (do ((b b/min (fx+ b 1))) ((fx> b b/max))
      (let* ((c (fx* a b)) (i (concatenate a (concatenate b c))))
        (when (pandigital? i)
          (hash-table-set! cache c #t))))))

(define (solve)
  (let ((acc (make-hash-table)))
    #|
    9 digits =>
    - either 2 digits * 3 digits
    - either 1 digits * 4 digits
    |#
    (helper! acc 10 99 100 999)
    (helper! acc 1 9 1000 9999)
    (foldl fx+ 0 (hash-table-keys acc))))

(let ((_ (solve)))
  (print _) (assert (= _ 45228)))
