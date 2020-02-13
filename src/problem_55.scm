(import euler)

(define (lychrel? n)
  (let helper ((x 0) (n n))
    (cond ((= x 50)
           #t)
          ((palindrome? (+ n (reverse-number n)))
           #f)
          (else
            (helper (add1 x) (+ n (reverse-number n)))))))

(define (main n)
  (do ((x 0 (add1 x))
       (acc 0 (if (lychrel? x)
                  (add1 acc)
                  acc)))
    ((= x n) acc)))

(display (main 10000))
(newline)
