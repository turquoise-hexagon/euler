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

(define (range start stop #!optional
          ;; set default step
          (step (cond ((< start stop)  1)
                      ((> start stop) -1)
                      (else 0))))
  ;; set comparator
  (let ((comparator (cond ((> step 0) >)
                          ((< step 0) <)
                          (else =))))
    (let loop ((i start) (acc '()))
      (if (comparator i stop)
        (reverse acc)
        (loop (+ i step) (cons i acc))))))

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
                    (_ (+ (* i n) (hash-table-ref mem x))))))
              (range 0 (- n 1)))
            (_ -1)))))))

(define (divisors n)
  (sort (foldl
          (lambda (acc i)
            (if (= (modulo n i) 0)
              (let ((t (quotient n i)))
                (cons t (cons i acc)))
              acc))
          '() (range 1 (sqrt n)))
        <))

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

(define (trial-division-prime? n)
  (call/cc
    (lambda (_)
      (for-each
        (lambda (i)
          (cond ((= n i) (_ #t))
                ((= (modulo n i) 0) (_ #f))))
        STORED-PRIMES)
      (_ #t))))

(define (spsp? n a)
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
    ((< n 1000000) (trial-division-prime? n))
    (else
      (call/cc
        (lambda (_)
          (for-each
            (lambda (a)
              (unless (spsp? n a)
                (_ #f)))
            '(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97))
          (_ #t))))))

(define (rho-factor n c)
  ;; programming praxis
  (let ((f (lambda (x) (modulo (+ (* x x) c) n))))
    (let loop ((t 2) (h 2) (d 1))
      (cond ((= d 1)
             (let* ((t (f t))
                    (h (f h))
                    (h (f h))
                    (d (gcd (- t h) n)))
               (loop t h d)))
            ((= d n) (rho-factor n (+ c 1)))
            ((prime? d) d)
            (else    (rho-factor d (+ c 1)))))))

(define (factorize n)
  (let loop ((n n) (acc '()))
    ;; handle base cases
    (cond
      ((< n 2) acc)
      ((even? n) (loop (/ n 2) (cons 2 acc)))
      (else (let loop ((n n) (acc acc))
              (if (prime? n)
                (cons n acc)
                (let ((f (rho-factor n 1)))
                  (loop (/ n f) (cons f acc)))))))))

(define (primes n)
  (let ((sieve (make-vector (+ n 1) #t)))
    (for-each
      (lambda (i)
        (when (vector-ref sieve i)
          (for-each
            (lambda (j)
              (vector-set! sieve j #f))
            (range (* i i) n i))))
      (range 2 (sqrt n)))
    (foldr
      (lambda (i acc)
        (if (vector-ref sieve i)
          (cons i acc)
          acc))
      '() (range 2 n))))
