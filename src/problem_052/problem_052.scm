(define (anagram? a b)
  (let ((acc (make-vector 10 0)))
    (define (_anagram? n increment)
      (let loop ((n n))
        (unless (= n 0)
          (let ((_ (modulo n 10)))
            (vector-set! acc _
              (+ (vector-ref acc _) increment)))
          (loop (quotient n 10)))))
    (_anagram? a +1)
    (_anagram? b -1)
    (let loop ((i 0))
      (if (> i 9)
        #t
        (if (= (vector-ref acc i) 0)
          (loop (+ i 1))
          #f)))))

(define (solve n)
  (let loop ((i 1))
    (let subloop ((m 2))
      (if (> m n)
        i
        (if (anagram? i (* i m))
          (subloop (+ m 1))
          (loop (+ i 1)))))))

(print (solve 6))
