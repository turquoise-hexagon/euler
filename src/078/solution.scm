(import
  (srfi 69))

(define cache
  (make-hash-table))

(define (pentagonal/h n)
  (if (odd? n)
    (/ (+ n 1) 2)
    (+ n 1)))

(define (pentagonal n)
  (if (> n 1)
    (+ (pentagonal   (- n 1))
       (pentagonal/h (- n 1)))
    1))

(define (sign n)
  (if (> (modulo (- n 1) 4) 1)
    -1
    +1))

(define (partition n)
  (if (hash-table-exists? cache n)
    (hash-table-ref cache n)
    (if (< n 2) 1
      (let loop ((i 1) (acc 0))
        (let ((p (pentagonal i)))
          (if (> p n)
            (begin
              (hash-table-set! cache n acc)
              acc)
            (loop (+ i 1)
              (+ acc (* (sign i) (partition (- n p)))))))))))

(define (solve n)
  (let loop ((i 1))
    (if (= (modulo (partition i) n) 0)
      i
      (loop (+ i 1)))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 55374)))
