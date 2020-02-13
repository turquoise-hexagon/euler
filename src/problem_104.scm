(define (first-digits n)
  (let* ((str (number->string n))
         (len (string-length str)))
    (string->number (if (> len 10)
                        (substring str 0 10)
                        str))))

(define tmp
  (expt 10 10))

(define (last-digits n)
  (remainder n tmp))

(define (pandigital? n)
  (let helper ((n n) (acc (list)))
    (cond ((= (length acc) 9)
           #t)
          ((zero? n)
           #f)
          (else
            (helper (quotient n 10)
                    (let ((m (remainder n 10)))
                      (if (or (zero? m)
                              (member m acc))
                          acc
                          (cons m acc))))))))

(define (main)
  (do ((a 0 (+ a b))
       (b 1 a)
       (acc 0 (add1 acc)))
    ((and (pandigital? (last-digits a))
          (pandigital? (first-digits a)))
     acc)))

(display (main))
(newline)
