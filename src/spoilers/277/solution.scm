(import
  (srfi 69)
  (only (srfi 152) substring))

(define-inline (next proc n)
  (case (modulo n 3)
    ((0) (cons #\D (proc (quotient (+ (* 1 n) 0) 3))))
    ((1) (cons #\U (proc (quotient (+ (* 4 n) 2) 3))))
    ((2) (cons #\d (proc (quotient (- (* 2 n) 1) 3))))))

(define sequence
  (let ((cache (make-hash-table)))
    (hash-table-set! cache 1 '())
    (lambda (n)
      (list->string
        (let loop ((n n))
          (if (hash-table-exists? cache n)
            (hash-table-ref cache n)
            (let ((acc (next loop n)))
              (hash-table-set! cache n acc)
              acc)))))))

(define (match? n str)
  (let ((res (sequence n)))
    (string=? str
      (substring res 0
        (min
          (string-length res)
          (string-length str))))))

(define (solve start str)
  (let ((len (string-length str)))
    (let loop ((acc start) (increment 1) (index 1))
      (if (> index len)
        acc
        (let ((str (substring str 0 index)))
          (let subloop ((i acc))
            (if (match? i str)
              (loop i (* increment 3) (+ index 1))
              (subloop (+ i increment)))))))))

(let ((_ (solve #e1e15 "UDDDUdddDDUDDddDdDddDDUDDdUUDd")))
  (print _) (assert (= _ 1125977393124310)))
