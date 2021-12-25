(define STORED-PRIMES
  '(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97
    101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191
    193 197 199 211 223 227 229 233 239 241 251 257 263 269 271 277 281 283
    293 307 311 313 317 331 337 347 349 353 359 367 373 379 383 389 397 401
    409 419 421 431 433 439 443 449 457 461 463 467 479 487 491 499 503 509
    521 523 541 547 557 563 569 571 577 587 593 599 601 607 613 617 619 631
    641 643 647 653 659 661 673 677 683 691 701 709 719 727 733 739 743 751
    757 761 769 773 787 797 809 811 821 823 827 829 839 853 857 859 863 877
    881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 991 997))

;; ---
;; general utilities
;; ---

(define (range start stop #!optional (step (signum (- stop start))))
  ;; set comparator
  (let ((comp (cond ((> step 0) <)
                    ((< step 0) >)
                    (else =))))
    (let loop ((i stop) (acc '()))
      (if (comp i start)
        acc
        (loop (- i step) (cons i acc))))))

;; ---
;; arrays
;; ---

(define-record array content dimensions indexes)

(define (_array-content lst)
  (let loop ((current lst))
    (if (list? current)
      (list->vector (map loop current))
      current)))

(define (_array-dimensions lst)
  (let loop ((current lst))
    (if (list? current)
      (cons (length current) (loop (car current)))
      '())))

(define (_array-indexes lst)
  (apply product
    (map
     (lambda (i)
       (range 0 (- i 1)))
     lst)))

(define (_array-copy array)
  (let loop ((current (array-content array)))
    (if (vector? current)
      (vector-copy (vector-map loop current))
      current)))

(define (list->array lst)
  (let* ((content (_array-content lst))
         (dimensions (_array-dimensions lst))
         (indexes (_array-indexes dimensions)))
    (make-array content dimensions indexes)))

(define (array->list array)
  (let loop ((current (array-content array)))
    (if (vector? current)
      (map loop (vector->list current))
      current)))

(define (array-copy array)
  (make-array
    (_array-copy array)
    (array-dimensions array)
    (array-indexes array)))

(define (array-ref array coord)
  (foldl
    (lambda (acc index)
      (vector-ref acc index))
    (array-content array) coord))

(define (array-set! array coord value)
  (let loop ((current (array-content array)) (coord coord))
    (receive (index coord) (car+cdr coord)
      (let ((next (vector-ref current index)))
        (if (vector? next)
          (loop next coord)
          (vector-set! current index value))))))

(define (array-exists? array coord)
  (every
    (lambda (index dimension)
      (< -1 index dimension))
    coord (array-dimensions array)))

;; ---
;; math functions
;; ---

(define (factorial n)
  (if (= n 0)
    1
    (let loop ((i 1) (acc n))
      (if (> acc i)
        (* (loop (+ i i) acc)
           (loop (+ i i) (- acc i)))
        acc))))

(define (expt-mod base expo mod)
  (let loop ((base base) (expo expo) (acc 1))
    (if (= expo 0)
      acc
      (loop (modulo (* base base) mod)
        (quotient expo 2)
        (if (odd? expo) (modulo (* base acc) mod)
          acc)))))

(define (discrete-log g h p)
  ;; https://gist.github.com/0xtowel/b4e7233fc86d8bb49698e4f1318a5a73
  (let ((n (inexact->exact (ceiling (sqrt (- p 1))))))
    (let ((mem (make-hash-table)))
      (for-each
        (lambda (i)
          (hash-table-set! mem (expt-mod g i p) i))
        (range 0 (- n 1)))
      (let ((c (expt-mod g (* n (- p 2)) p)))
        (call/cc
          (lambda (_)
            (for-each
              (lambda (i)
                (let ((x (modulo (* h (expt-mod c i p)) p)))
                  (when (hash-table-exists? mem x)
                    (let ((a (+ (* i n) (hash-table-ref mem x))))
                      (when (> a 0) (_ a))))))
              (range 0 (- n 1)))
            (_ -1)))))))

(define (divisors n)
  (do ((i 1 (+ i 1))
       (acc '() (if (= (modulo n i) 0)
                  (let ((q (quotient n i)))
                    (cons q (cons i acc)))
                  acc)))
    ((> (* i i) n)
     (sort acc <))))

;; ---
;; operations on lists
;; ---

(define (product . lst)
  (foldr
    (lambda (a acc)
      (join (map
              (lambda (b)
                (map (cut cons b <>) acc))
              a)))
    '(()) lst))

(define (combinations lst n)
  (if (= n 0)
    '(())
    (join (map
            (lambda (i)
              (map (cut cons <> i) lst))
            (combinations lst (- n 1))))))

(define (powerset lst n)
  (if (= n 0)
    '(())
    (if (null? lst)
      '()
      (append (map
                (lambda (i)
                  (cons (car lst) i))
                (powerset (cdr lst) (- n 1)))
              (powerset (cdr lst) n)))))

(define (permutations lst)
  (if (null? lst)
    '()
    (if (null? (cdr lst))
      `(,lst)
      (let loop ((lst '()) (a (car lst)) (b (cdr lst)))
        (append (map
                  (lambda (i)
                    (cons a i))
                  (permutations (append lst b)))
                (if (null? b)
                  '()
                  (loop (cons a lst) (car b) (cdr b))))))))

;; ---
;; operations on digits
;; ---

(define (number->list n #!optional (base 10))
  (let loop ((n n) (acc '()))
    (if (= n 0)
      acc
      (let ((q (quotient n base)) (r (remainder n base)))
        (loop q (cons r acc))))))

(define (list->number lst #!optional (base 10))
  (foldl
    (lambda (acc i)
      (+ (* acc base) i))
    0 lst))

(define (digitsum n #!optional (base 10))
  (foldl + 0 (number->list n)))

(define (palindrome? n #!optional (base 10))
  (let ((lst (number->list n base)))
    (equal? lst (reverse lst))))

;; ---
;; operations on primes
;; ---

(define (_trial-division-prime? n)
  (call/cc
    (lambda (_)
      (for-each
        (lambda (i)
          (cond ((= n i) (_ #t))
                ((= (modulo n i) 0) (_ #f))))
        STORED-PRIMES)
      (_ #t))))

(define (_spsp? n a)
  ;; programming praxis
  (do ((d (- n 1) (/ d 2))
       (s 0 (+ s 1)))
    ((odd? d)
     (let ((t (expt-mod a d n)))
       (if (= t 1)
         #t
         (do ((s s (- s 1))
              (t t (expt-mod t 2 n)))
           ((or (= s 0)
                (= t (- n 1)))
            (> s 0))))))))

(define (prime? n)
  (cond
    ;; handle base cases
    ((< n 2) #f)
    ((< n 1000000) (_trial-division-prime? n))
    (else
      (call/cc
        (lambda (_)
          (for-each
            (lambda (a)
              (unless (_spsp? n a)
                (_ #f)))
            '(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97))
          (_ #t))))))

(define (_rho-factor n c)
  ;; programming praxis
  (let ((f (lambda (x) (modulo (+ (* x x) c) n))))
    (let loop ((t 2) (h 2) (d 1))
      (cond ((= d 1)
             (let* ((t (f t))
                    (h (f h))
                    (h (f h))
                    (d (gcd (- t h) n)))
               (loop t h d)))
            ((= d n) (_rho-factor n (+ c 1)))
            ((prime? d) d)
            (else    (_rho-factor d (+ c 1)))))))

(define (factorize n)
  (let loop ((n n) (acc '()))
    ;; handle base cases
    (cond
      ((< n 2) acc)
      ((even? n) (loop (/ n 2) (cons 2 acc)))
      (else (let loop ((n n) (acc acc))
              (if (prime? n)
                (cons n acc)
                (let ((f (_rho-factor n 1)))
                  (loop (/ n f) (cons f acc)))))))))

(define (primes n)
  (let ((sieve (make-vector (+ n 1) #t)))
    (do ((i 2 (+ i 1))) ((> (* i i) n))
      (when (vector-ref sieve i)
        (do ((j (* i i) (+ j i))) ((> j n))
          (vector-set! sieve j #f))))
    (do ((i n (- i 1))
         (acc '() (if (vector-ref sieve i)
                    (cons i acc)
                    acc)))
      ((< i 2) acc))))
