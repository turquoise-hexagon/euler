(import
  (euler))

(define (nth-permutation l n)
  (let loop ((l l) (i (length l)) (n (- n 1)))
    (if (null? l)
      '()
      (let-values (((q r) (quotient&remainder n (factorial (- i 1)))))
        (cons (list-ref l q) (loop (delete-at l q) (- i 1) r))))))

(define (solve n)
  (list->number (nth-permutation (range 0 9) n)))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 2783915460)))
