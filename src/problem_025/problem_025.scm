(define (number-length n)
  (string-length (number->string n)))

(define (solve n)
  (let solve/h ((a 0) (b 1) (acc 0))
    (if (= (number-length a) n)
        acc
        (solve/h b (+ a b) (+ acc 1)))))

(print (solve 1000))
