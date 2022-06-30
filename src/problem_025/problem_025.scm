(define (number-length n)
  (string-length (number->string n)))

(define (solve n)
  (let loop ((a 0) (b 1) (acc 0))
    (if (= (number-length a) n)
      acc
      (loop b (+ a b) (+ acc 1)))))

(print (solve 1000))
