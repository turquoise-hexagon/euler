(import
  (euler))

(define-constant lst '(1 3 7 9 13 27))

(define (valid? i)
  (if (or (= (modulo i  3) 0)
          (= (modulo i  7) 0)
          (= (modulo i 13) 0))
    #f
    (let ((_ (* i i)))
      (let loop ((i 1))
        (if (> i 27)
          #t
          (if (member i lst)
            (if (prime? (+ _ i))
              (loop (+ i 1))
              #f)
            (if (prime? (+ i _))
              #f
              (loop (+ i 1)))))))))

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
