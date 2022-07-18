(import
  (chicken sort)
  (euler)
  (srfi 1))

(define (make-valid? n)
  (let ((muls (range 1 n)))
    (lambda (i)
      (let ((tmp (map
                   (lambda (mul)
                     (sort (number->list (* i mul)) <))
                   muls)))
        (every equal? tmp (cdr tmp))))))

(define (solve n)
  (let ((valid? (make-valid? n)))
    (let loop ((i 1))
      (if (valid? i)
        i
        (loop (+ i 1))))))

(print (solve 6))
