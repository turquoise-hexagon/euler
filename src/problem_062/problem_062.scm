(import
  (chicken sort)
  (euler)
  (srfi 69))

(define (key n)
  (sort (number->list n) <))

(define (solve n)
  (let ((acc (make-hash-table)))
    (let loop ((i 1))
      (let* ((val (* i i i)) (key (key val)))
        (let ((tmp (cons val (hash-table-ref/default acc key '()))))
          (if (= (length tmp) n)
            (apply min tmp)
            (begin
              (hash-table-set! acc key tmp)
              (loop (+ i 1)))))))))

(print (solve 5))
