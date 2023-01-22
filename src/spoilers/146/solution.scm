(import
  (euler))

(define (valid? n)
  (if (and (case (modulo n 3)
             ((1 2) #t)
             (else #f))
           (case (modulo n 7)
             ((3 4) #t)
             (else #f))
           (case (modulo n 13)
             ((1 3 4 9 10 12) #t)
             (else #f)))
    (let ((_ (* n n)))
      (let loop ((i 1))
        (if (> i 27)
          #t
          (case i
            ((1 3 7 9 13 27)
             (if (prime? (+ _ i))
               (loop (+ i 1))
               #f))
            (else
              (if (prime? (+ _ i))
                #f
                (loop (+ i 1))))))))
    #f))

(define (solve n)
  (let loop ((i 0) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 10)
        (if (valid? i)
          (+ acc i)
          acc)))))

(let ((_ (solve #e15e7)))
  (print _) (assert (= _ 676333270)))
