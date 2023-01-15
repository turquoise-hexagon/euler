(import
  (srfi 69))

(define (f n)
  (let loop ((i n) (acc 0))
    (if (= i 0)
      acc
      (let ((q (quotient i 10)) (m (modulo i 10)))
        (loop q (+ acc (* m m)))))))

(define cache
  (alist->hash-table
    '((1  . #f)
      (89 . #t))))

(define (chain n)
  (let loop ((i n))
    (if (hash-table-exists? cache i)
      (let ((_ (hash-table-ref cache i)))
        (hash-table-set! cache n _)
        _)
      (loop (f i)))))

(define (solve n)
  (let loop ((i 1) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1)
        (if (chain i)
          (+ acc 1)
          acc)))))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 8581146)))
