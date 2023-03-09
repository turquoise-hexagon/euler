(define (P n)
  (if (= n 1)
    1
    (let ((i (quotient n 2)))
      (* 2 (+ (- i (P i)) 1)))))

(define (S n)
  (if (= n 1)
    1
    (if (even? n)
      (+ (P n) (S (- n 1)))
      (let ((i (quotient n 2)))
        (+ (* 4 (+ (- (quotient (* i (+ i 1)) 2) (S i)) i)) 1)))))

(let ((_ (modulo (S #e1e18) 987654321)))
  (print _) (assert (= _ 426334056)))
