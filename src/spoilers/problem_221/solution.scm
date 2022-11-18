(import
  (chicken sort)
  (euler)
  (srfi 69))

(define (alexandrians n)
  (let ((_ (+ (* n n) 1)))
    (map
      (lambda (i)
        (* n (+ n i) (+ (/ _ i) n)))
      (divisors _))))

(define (solve n)
  (let ((acc (make-hash-table)))
    (let loop ((i 1))
      (if (> i n)
        (let ((_ (hash-table-keys acc)))
          (list-ref (sort _ <) (- n 1)))
        (begin
          (for-each
            (lambda (_)
              (hash-table-set! acc _ #t))
            (alexandrians i))
          (loop (+ i 1)))))))

(print (solve 150000))
