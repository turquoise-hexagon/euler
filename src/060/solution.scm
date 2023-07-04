(import
  (chicken fixnum)
  (euler)
  (srfi 69)
  (except (srfi 1) concatenate))

(define-constant limit 10000)

(define (concatenate a b)
  (do ((i b (fx/ i 10))
       (a a (fx* a 10)))
    ((fx= i 0) (fx+ a b))))

(define (make-prime? limit)
  (let ((acc (make-vector limit #f)))
    (for-each
      (lambda (i)
        (vector-set! acc i #t))
      (primes limit))
    (lambda (n)
      (vector-ref acc n))))

(define (make-should-be-connected? limit)
  (let ((prime? (make-prime? (fx* limit limit))))
    (lambda (a b)
      (and
        (prime? (concatenate a b))
        (prime? (concatenate b a))))))

(define (connect! graph a b)
  (let ((acc (hash-table-ref/default graph a (make-hash-table))))
    (hash-table-set! acc b #t)
    (hash-table-set! graph a acc)))

(define (graph limit)
  (let ((acc (make-hash-table)) (should-be-connected? (make-should-be-connected? limit)))
    (for-each
      (lambda (pair)
        (apply
          (lambda (a b)
            (when (should-be-connected? a b)
              (connect! acc a b)
              (connect! acc b a)))
          pair))
      (combinations (primes limit) 2))
    acc))

(define (find-map fun lst)
  (let loop ((lst lst))
    (if (null? lst)
      #f
      (let ((acc (fun (car lst))))
        (if acc
          acc
          (loop (cdr lst)))))))

(define (connected? graph a b)
  (hash-table-exists? (hash-table-ref graph a) b))

(define (would-be-clique? graph node clique)
  (every
    (lambda (i)
      (connected? graph i node))
    clique))

(define (clique graph size)
  (find-map
    (lambda (node)
      (let loop ((node node) (len 0) (acc '()))
        (if (fx= len size)
          acc
          (let ((len (fx+ len 1)))
            (find-map
              (lambda (node)
                (loop node len (cons node acc)))
              (filter
                (lambda (node)
                  (would-be-clique? graph node acc))
                (hash-table-keys (hash-table-ref graph node))))))))
    (hash-table-keys graph)))

(define (solve size)
  (foldl fx+ 0 (clique (graph limit) size)))

(let ((_ (solve 5)))
  (print _) (assert (= _ 26033)))
