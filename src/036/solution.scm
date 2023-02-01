(import
  (chicken fixnum))

(define (palindrome? n #!optional (b 10))
  (let loop ((i n) (acc 0))
    (if (fx= i 0)
      (fx= n acc)
      (loop (fx/ i b) (fx+ (fx* acc b) (fxmod i b))))))

(define (solve n)
  (let loop ((i 0) (acc 0))
    (if (fx> i n)
      acc
      (loop (fx+ i 1)
        (if (and (palindrome? i)
                 (palindrome? i 2))
          (fx+ acc i)
          acc)))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 872187)))
