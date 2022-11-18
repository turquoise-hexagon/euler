(import
  (euler))

(define lst
  '(1 3 7 9 13 27))

(define (valid? n)
  (let ((squared (* n n)))
    (let loop ((i 1))
      (if (> i 27)
        #t
        (let ((tmp (+ squared i)))
          (if (member i lst)
            (if (prime? tmp)
              (loop (+ i 1))
              #f)
            (if (prime? tmp)
              #f
              (loop (+ i 1)))))))))

(define (solve n)
  (let loop ((i 10) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 10)
         (if (valid? i)
           (+ acc i)
           acc)))))

(print (solve 150000000))
