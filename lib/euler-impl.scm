(define stored-primes
  '(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97
    101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191
    193 197 199 211 223 227 229 233 239 241 251 257 263 269 271 277 281 283
    293 307 311 313 317 331 337 347 349 353 359 367 373 379 383 389 397 401
    409 419 421 431 433 439 443 449 457 461 463 467 479 487 491 499 503 509
    521 523 541 547 557 563 569 571 577 587 593 599 601 607 613 617 619 631
    641 643 647 653 659 661 673 677 683 691 701 709 719 727 733 739 743 751
    757 761 769 773 787 797 809 811 821 823 827 829 839 853 857 859 863 877
    881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 991 997))

(define (range start stop step)
  (let ((comparison (if (> step 0) > <)))
    (let range/h ((i start) (acc '()))
      (if (comparison i stop) (reverse acc)
          (range/h (+ i step) (cons i acc))))))

(define (product . lsts)
  (foldr
    (lambda (a acc)
      (apply append
             (map
               (lambda (x)
                 (map (cut cons x <>) acc))
               a)))
    '(()) lsts))

(define (combinations l n)
  (if (= n 0)
      '(())
      (apply append
             (map
               (lambda (a)
                 (map (cut cons <> a) l))
               (combinations l (- n 1))))))

(define (powerset l n)
  (cond ((= n 0) '(()))
        ((null? l) '())
        (else (append (map
                        (lambda (a)
                          (cons (car l) a))
                        (powerset (cdr l) (- n 1)))
                      (powerset (cdr l) n)))))

(define (permutations l)
  (cond ((null? l) '())
        ((null? (cdr l)) `(,l))
        (else (let permutations/h ((l '()) (a (car l)) (b (cdr l)))
                (append
                  (map
                    (lambda (x)
                      (cons a x))
                    (permutations (append l b)))
                  (if (null? b)
                      '()
                      (permutations/h (cons a l) (car b) (cdr b))))))))

(define (list->number lst #!optional (base 10))
  (foldl
    (lambda (acc n)
      (+ n (* acc base)))
    0 lst))

(define (number->list n #!optional (base 10))
  (let number->list/h ((n n) (acc '()))
    (if (= n 0)
      acc
      (let ((q (quotient n base)) (r (remainder n base)))
        (number->list/h q (cons r acc))))))

(define (digitsum n)
  (apply + (number->list n)))

(define (palindrome? n #!optional (base 10))
  (let ((lst (number->list n base)))
    (equal? lst (reverse lst))))

(define (factorial n)
  (if (= n 0) 1
      (let factorial/h ((i 1) (acc n))
        (if (> acc i)
            (* (factorial/h (+ i i) acc)
               (factorial/h (+ i i) (- acc i)))
            acc))))

(define (divisors n)
  (sort (foldl
          (lambda (divisors i)
            (if (= (modulo n i) 0)
                (let ((t (/ n i)))
                  (cons i (cons t divisors)))
                divisors))
          '() (range 1 (sqrt n) 1))
        <))

(define (expt-mod base expo mod)
  (let expt-mod/h ((base base) (expo expo) (res 1))
    (if (= expo 0)
        res
        (expt-mod/h (modulo (* base base) mod) (quotient expo 2)
                    (if (odd? expo) (modulo (* base res) mod)
                        res)))))

(define (trial-division-prime? n)
  (call/cc
    (lambda (return)
      (for-each
        (lambda (i)
          (when (= i n)
            (return #t))
          (when (= (modulo n i) 0)
            (return #f)))
        stored-primes)
      (return #t))))

(define (prime? n)
  (if (< n 2) #f
      (if (< n 1000000) (trial-division-prime? n)
          (call/cc
            (lambda (return)
              (for-each
                (lambda (a)
                  (unless (let ((n n) (a a))
                            (do ((d (- n 1) (/ d 2)) (s 0 (+ s 1)))
                              ((odd? d) (let ((t (expt-mod a d n)))
                                          (if (= t 1) #t
                                              (do ((s s (- s 1)) (t t (expt-mod t 2 n)))
                                                ((or (= s 0) (= t (- n 1))) (> s 0))))))))
                    (return #f)))
                '(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97))
              (return #t))))))

(define (rho-factor n c)
  (let ((f
          (lambda (x)
            (modulo (+ (* x x) c) n))))
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
  (let loop/1 ((n n) (acc '()))
    (cond ((< n 2)
           acc)
          ((even? n)
           (loop/1 (/ n 2) (cons 2 acc)))
          (else (let loop/2 ((n n) (acc acc))
                  (if (prime? n) (cons n acc)
                      (let ((f (rho-factor n 1)))
                        (loop/2 (/ n f) (cons f acc)))))))))

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

(define (discrete-log base res mod)
  (let ((n (inexact->exact (ceiling (sqrt mod)))))
    (let ((mem (make-hash-table)))
      (for-each
        (lambda (i)
          (hash-table-set! mem (expt-mod base i mod) i))
        (range 0 (- n 1) 1))
      (let ((factor (expt-mod base (* n (- mod 2)) mod)))
        (call/cc
          (lambda (return)
            (for-each
              (lambda (i)
                (let ((tmp (modulo (* res (expt-mod factor i mod)) mod)))
                  (let ((res (hash-table-ref/default mem tmp #f)))
                    (when res (let ((ans (+ (* i n) res)))
                               (when (> ans 0) (return ans)))))))
              (range 0 (- n 1) 1))
            (return -1)))))))
