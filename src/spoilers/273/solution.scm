(import
  (chicken fixnum)
  (euler)
  (srfi 1)
  (srfi 69))

(define (bruteforce n)
  (let loop/i ((i 1))
    (let loop/j ((j 1))
      (let ((sum (fx+ (fx* i i) (fx* j j))))
        (if (fx> sum n)
          (loop/i (fx+ i 1))
          (if (fx= sum n)
            (list (cons i j))
            (loop/j (fx+ j 1))))))))

(define (finesse a b)
  (let
    ((acc/a (s a))
     (acc/b (s b)))
    (foldl
      (lambda (acc lst/a)
        (foldl
          (lambda (acc lst/b)
            (let*
              ((i (car lst/a)) (j (cdr lst/a))
               (k (car lst/b)) (l (cdr lst/b))
               (m (fx* i k)) (n (fx* j l))
               (o (fx* i l)) (p (fx* j k)))
              (cons*
                (cons (fx+ m n) (fxabs (fx- o p)))
                (cons (fxabs (fx- m n)) (fx+ o p))
                acc)))
          acc acc/b))
      '() acc/a)))

(define (iterate n)
  (let
    ((head (car n))
     (tail (cdr n)))
    (if (null? tail)
      (bruteforce head)
      (finesse (list head) tail))))

(define (id n)
  (foldl fx* 1 n))

(define s
  (let ((cache (make-hash-table)))
    (lambda (n)
      (let ((id (id n)))
        (if (hash-table-exists? cache id)
          (hash-table-ref cache id)
          (let ((acc (iterate n)))
            (hash-table-set! cache id acc)
            acc))))))

(define (S n)
  (foldl
    (lambda (acc i)
      (fx+ acc (fxmin (car i) (cdr i))))
    0 (s n)))

(define (4k+1? n)
  (fx= (fxmod (fx- n 1) 4) 0))

(define (solve limit)
  (foldl
    (lambda (acc i)
      (fx+ acc (S i)))
    0 (delete-first (powerset (filter 4k+1? (primes limit))) '() eq?)))

(let ((_ (solve 150)))
  (print _) (assert (= _ 2032447591196869022)))
