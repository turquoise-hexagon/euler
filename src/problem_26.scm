(define (digits n d)
  (let helper ((x n) (acc (list)))
    (let ((tmp (remainder x d)))
      (if (member tmp acc)
          (length acc)
          (helper (* tmp 10) (cons tmp acc))))))

(define (main n)
  (let helper ((x 1) (acc 1) (val 0))
    (if (= x n)
        acc
        (let* ((cur (digits 1 x))
               (tmp (> cur val)))
          (helper (add1 x)
                  (if tmp x acc)
                  (if tmp cur acc))))))

(display (main 1000))
(newline)
