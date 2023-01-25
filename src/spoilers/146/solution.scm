(import
  (chicken fixnum)
  (euler))

(define (valid? n)
  (if (and (case (fxmod n 3)
             ((1 2) #t)
             (else #f))
           (case (fxmod n 7)
             ((3 4) #t)
             (else #f))
           (case (fxmod n 13)
             ((1 3 4 9 10 12) #t)
             (else #f)))
    (let ((_ (fx* n n)))
      (let loop ((i 1))
        (if (fx> i 27)
          #t
          (case i
            ((1 3 7 9 13 27)
             (if (prime? (fx+ _ i))
               (loop (fx+ i 1))
               #f))
            (else
              (if (prime? (fx+ _ i))
                #f
                (loop (fx+ i 1))))))))
    #f))

(define (solve n)
  (let loop ((i 0) (acc 0))
    (if (fx> i n)
      acc
      (loop (fx+ i 10)
        (if (valid? i)
          (fx+ acc i)
          acc)))))

(let ((_ (solve #e15e7)))
  (print _) (assert (= _ 676333270)))
