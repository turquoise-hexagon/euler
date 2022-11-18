(import
  (chicken sort)
  (euler)
  (srfi 69))

(define (id n)
  (sort (number->list n) <))

(define (solve n)
  (let ((cache (make-hash-table)))
    (let loop ((i 1))
      (let* ((value (expt i 3)) (id (id value))
             (acc (hash-table-update!/default cache id
                    (lambda (_)
                      (cons value _))
                    '())))
        (if (= (length acc) n)
          (apply min acc)
          (loop (+ i 1)))))))

(print (solve 5))
