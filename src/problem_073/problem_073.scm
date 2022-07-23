(import
  (euler)
  (srfi 1))

(define (solve n)
  (count
    (lambda (i)
      (< 1/3 i 1/2))
    (flatten
      (map
        (lambda (d)
          (map
            (lambda (n)
              (/ n d))
            (filter
              (lambda (n)
                (= (gcd n d) 1))
              (range 1 (- d 1) 1))))
        (range 1 n)))))

(print (solve 12000))
