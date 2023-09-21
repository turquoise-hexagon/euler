(import
  (chicken fixnum)
  (euler))

(define (pi n target)
  (if (fx= n 1)
    #f
    (let loop ((i 1) (a 1) (b 1))
      (if (fx> i target)
        #f
        (if (and (fx= a 0)
                 (fx= b 1))
          (fx= i target)
          (loop (fx+ i 1) b (fxmod (fx+ a b) n)))))))

(define (solve limit target)
  (foldl
    (lambda (acc i)
      (if (fx> i limit)
        acc
        (if (pi i target)
          (fx+ acc i)
          acc)))
    0 (divisors (fibonacci target))))

(let ((_ (solve #e1e9 120)))
  (print _) (assert (= _ 44511058204)))
