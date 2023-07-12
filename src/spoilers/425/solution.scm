(import
  (chicken fixnum)
  (euler)
  (srfi 69))

(define (make-prime? p l)
  (let ((acc (make-vector (fx+ l 1) #f)))
    (for-each
      (lambda (i)
        (vector-set! acc i #t))
      p)
    (lambda (n)
      (vector-ref acc n))))

(define (should-be-connected? ? n c)
  (if (? c)
    (do ((c c (fx/ c 10))
         (n n (fx/ n 10)))
      ((fx= c 0) (fx< n 10)))
    #f))

(define (connect! g n c)
  (let ((_ (hash-table-ref/default g n (make-hash-table))))
    (hash-table-set! _ c 0)
    (hash-table-set! g n _)))

(define (make-iterate! p l)
  (let ((prime? (make-prime? p l)))
    (lambda (g n)
      (do ((i n (fx/ i 10))
           (o 1 (fx* o 10)))
        ((fx= i 0))
        (let* ((d (fxmod i 10)) (s (fx- n (fx* d o))))
          (do ((r 0 (fx+ r 1))) ((fx= r 10))
            (unless (fx= d r)
              (let ((c (fx+ s (fx* r o))))
                (when (should-be-connected? prime? n c)
                  (connect! g n c)
                  (connect! g c n))))))))))

(define (graph p l)
  (let ((acc (make-hash-table)) (iterate! (make-iterate! p l)))
    (for-each
      (lambda (i)
        (iterate! acc i))
      p)
    acc))

(define (find-path g s)
  (let ((acc (make-hash-table)))
    (do ((q (priority-queue-insert (priority-queue fx<) s)
            (let* ((n (priority-queue-first q)) (m (fxmax n (hash-table-ref/default acc n 0))))
              (foldl
                (lambda (q c)
                  (if (fx< m (hash-table-ref/default acc c most-positive-fixnum))
                    (begin
                      (hash-table-set! acc c m)
                      (priority-queue-insert q c))
                    q))
                (priority-queue-rest q) (hash-table-keys (hash-table-ref g n))))))
      ((priority-queue-empty? q) acc))))

(define (solve l s)
  (let* ((p (primes l)) (g (graph p l)) (d (find-path g s)))
    (foldl
      (lambda (acc i)
        (if (fx> (hash-table-ref/default d i most-positive-fixnum) i)
          (fx+ acc i)
          acc))
      0 (delete-first p s fx=))))

(let ((_ (solve #e1e7 2)))
  (print _) (assert (= _ 46479497324)))
