(import
  (chicken fixnum)
  (srfi 69))

(define (memoize function)
  (let ((cache (make-hash-table)))
    (lambda (n)
      (if (hash-table-exists? cache n)
        (hash-table-ref cache n)
        (let ((acc (function n)))
          (hash-table-set! cache n acc)
          acc)))))

(define (a n i)
  (if (fx= (fx/ n i) i)
    0
    (let ((_ (fx+ i 1)))
      (fx* (fx- (fx/ n i)
                (fx/ n _))
           (PHI i)))))

(define (_PHI n)
  (fx- (fx/ (fx* n (fx+ n 1)) 2)
       (do ((i 2 (fx+ i 1))
            (acc (a n 1) (fx+ acc (fx+ (a n i) (PHI (fx/ n i))))))
         ((fx> (fx* i i) n) acc))))

(define (_f n)
  (do ((i n (fx/ i 2))
       (t 1 (fx* t 2))
       (acc 0 (fx+ acc (fx* t (g (fx/ n (fx* t 2)))))))
    ((fx= i 0) acc)))

(define (_g n)
  (fx- (PHI n) (f n)))

(define PHI (memoize _PHI))
(define f (memoize _f))
(define g (memoize _g))

(let ((_ (g #e5e8)))
  (print _) (assert (= _ 50660591862310323)))
