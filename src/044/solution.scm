(import
  (chicken fixnum))

(define-constant limit #e1e7)

(define-syntax pentagonal
  (syntax-rules ()
    ((_ n)
     (fx/ (fx* n (fx- (fx* 3 n) 1)) 2))))

(define (pentagonals limit)
  (let loop ((i 1) (acc '()))
    (let ((p (pentagonal i)))
      (if (fx> p limit)
        acc
        (loop (fx+ i 1) (cons p acc))))))

(define (make-pentagonal? limit)
  (let ((acc (make-vector (fx+ limit 1) #f)))
    (for-each
      (lambda (p)
        (vector-set! acc p #t))
      (pentagonals limit))
    (define (pentagonal? n)
      (vector-ref acc n))
    pentagonal?))

(define (solve)
  (let ((pentagonal? (make-pentagonal? (fx* limit 2))))
    (let loop ((a (pentagonals limit)))
      (let subloop ((b a))
        (if (null? b)
          (loop (cdr a))
          (let ((s (fx+ (car a) (car b)))
                (d (fx- (car a) (car b))))
            (if (and (pentagonal? s)
                     (pentagonal? d))
              d
              (subloop (cdr b)))))))))

(let ((_ (solve)))
  (print _) (assert (= _ 5482660)))
