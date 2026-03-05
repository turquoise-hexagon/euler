(import
  (euler)
  (srfi 69))

(define (id index digitsum flag)
  (string-append
    (number->string    index) " "
    (number->string digitsum) " "
    (if flag "1" "0")))

(define-inline (function__ digits index digitsum flag)
  (if (null? digits) (if (prime? digitsum) 1 0)
    (let ((limit (if flag (car digits) 9)) (digits (cdr digits)) (index (+ index 1)))
      (let loop ((i 0) (acc 0))
        (if (> i limit)
          acc
          (loop (+ i 1) (+ acc (function_ digits index (+ digitsum i) (and flag (= i limit))))))))))

(define (function n)
  (define function_
    (let ((mem (make-hash-table)))
      (lambda (digits index digitsum flag)
        (let ((id (id index digitsum flag)))
          (if (hash-table-exists? mem id)
            (hash-table-ref mem id)
            (let ((acc (function__ digits index digitsum flag)))
              (hash-table-set! mem id acc)
              acc))))))
  (function_ (number->list n) 0 0 #t))

(define (high-bound n)
  (do ((i 1 (* i 2)))
    ((> (function i) n) i)))

(define (solve n)
  (let loop ((low 1) (high (high-bound n)))
    (if (< low high)
      (let ((mid (quotient (+ low high) 2)))
        (if (< (function mid) n)
          (loop (+ mid 1) high)
          (loop low mid)))
      low)))

(let ((_ (solve #e1e16)))
  (print _) (assert (= _ 45009328011709400)))
