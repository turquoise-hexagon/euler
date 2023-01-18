(import
  (only (srfi 152) substring))

(define (pandigital? n)
  (if (= (modulo n 9) 0)
    (let ((acc (make-vector 10 #f)))
      (let loop ((n n))
        (let ((_ (modulo n 10)))
          (if (vector-ref acc _)
            #f
            (begin
              (vector-set! acc _ #t)
              (if (= n 0)
                (let loop ((i 0))
                  (if (= i 10)
                    #t
                    (if (vector-ref acc i)
                      (loop (+ i 1))
                      #f)))
                (loop (quotient n 10))))))))
    #f))

(define (first-9 n)
  ;; wish i found a better way to do this
  (string->number (substring (number->string n) 0 9)))

(define (last-9 n)
  (modulo n #e1e10))

(define (solve)
  (let loop ((a 1) (b 0) (acc 1))
    (if (and (pandigital? (last-9  a))
             (pandigital? (first-9 a)))
      acc
      (loop (+ a b) a (+ acc 1)))))

(let ((_ (solve)))
  (print _) (assert (= _ 329468)))
