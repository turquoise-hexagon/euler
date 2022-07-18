(import
  (chicken bitwise))

(define limit 987654321)

(define (pandigital? n)
  (let loop ((i n) (cnt 0) (acc 0))
    (if (= i 0)
      (= acc (- (arithmetic-shift 1 cnt) 1))
      (let ((tmp (bitwise-ior acc (arithmetic-shift 1 (- (modulo i 10) 1)))))
        (if (= tmp acc)
          #f
          (loop (quotient i 10) (+ cnt 1) tmp))))))

(define (concatenate a b)
  (let loop ((i b) (a a))
    (if (= i 0)
      (+ a b)
      (loop (quotient i 10) (* a 10)))))

(define (generate n)
  (let loop ((i 1) (acc 0))
    (let ((tmp (concatenate acc (* n i))))
      (if (> tmp limit)
        acc
        (loop (+ i 1) tmp)))))

(define (solve)
  (let loop ((i 1) (acc 0))
    (if (> i 9999)
      acc
      (loop (+ i 1)
        (let ((tmp (generate i)))
          (if (and (pandigital? tmp) (> tmp acc))
            tmp
            acc))))))

(print (solve))
