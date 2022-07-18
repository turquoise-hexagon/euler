(import
  (euler))

(define limit 50)

(define (reverse-number n)
  (let loop ((i n) (acc 0))
    (if (= i 0)
      acc
      (let ((q (quotient i 10)) (m (modulo i 10)))
        (loop q (+ (* acc 10) m))))))

(define (lychrel? n)
  (let loop ((i n) (cnt 0))
    (if (> cnt limit)
      #t
      (let ((tmp (+ i (reverse-number i))))
        (if (palindrome? tmp)
          #f
          (loop tmp (+ cnt 1)))))))

(define (solve n)
  (let loop ((i 1) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1)
        (if (lychrel? i)
          (+ acc 1)
          acc)))))

(print (solve 10000))
