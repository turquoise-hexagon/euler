(import
  (chicken fixnum)
  (chicken sort)
  (euler)
  (srfi 1))

(define-constant limit #e2e5)

(define (subprime-proof? head tail digit order)
  (let loop ((replacement 0))
    (if (fx= replacement 10)
      #t
      (if (fx= replacement digit)
        (loop (fx+ replacement 1))
        (let ((_ (fx+? (fx+? head tail) (fx*? replacement order))))
          (if (and _ (prime? _))
            #f
            (loop (fx+ replacement 1))))))))

(define (prime-proof? n)
  (let loop ((i n) (order 1) (tail 0))
    (if (fx= i 0)
      #t
      (let* ((digit (fxmod i 10)) (next (fx* order 10)) (head (fx* (fx/ n next) next)))
        (if (subprime-proof? head tail digit order)
          (loop (fx/ i 10) next (fx+ tail (fx* digit order)))
          #f)))))

(define (submatch? a b)
  (let loop ((a a) (b b))
    (if (fx= b 0)
      #t
      (if (fx= (fxmod a 10)
               (fxmod b 10))
        (loop (fx/ a 10)
              (fx/ b 10))
        #f))))

(define (match? a b)
  (let loop ((a a))
    (if (fx> b a)
      #f
      (if (submatch? a b)
        #t
        (loop (fx/ a 10))))))

(define (generate primes fun)
  (let loop ((lst primes))
    (if (null? lst)
      '()
      (cons (fun (car lst)) (loop (cdr lst))))))

(define (combine a b)
  (let loop ((a a) (b (cdr b)) (acc '()))
    (if (null? b)
      acc
      (let subloop ((c b) (acc acc))
        (if (null? c)
          (loop (cdr a) (cdr b) acc)
          (let ((_ (fx*? (car a) (car c))))
            (if _
              (subloop (cdr c) (cons _ acc))
              acc)))))))

(define (solve index pattern)
  (let* ((primes (primes limit))
         (a (generate primes (lambda (i) (fx* i i))))
         (b (generate primes (lambda (i) (fx* i (fx* i i))))))
    (list-ref
      (sort
        (filter
          (lambda (i)
            (and (match? i pattern) (prime-proof? i)))
          (append
            (combine a b)
            (combine b a)))
        fx<)
      (fx- index 1))))

(let ((_ (solve 200 200)))
  (print _) (assert (= _ 229161792008)))
