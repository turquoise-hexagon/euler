(import
  (chicken sort)
  (euler))

(define (search array n)
  (let loop ((l 0) (h (- (vector-length array) 1)))
    (if (< l h)
      (let ((m (quotient (+ l h) 2)))
        (if (< n (vector-ref array m))
          (loop l m)
          (loop (+ m 1) h)))
      (vector-ref array (- l 1)))))

(define (solve n)
  (let* ((primes (primes n)) (len (length primes)) (limit (sqrt (apply * primes))))
    (define (helper i end acc)
      (if (= i end)
          (if (> limit acc)
              (list acc)
              '())
          (append
            (helper (+ i 1) end (* acc (list-ref primes i)))
            (helper (+ i 1) end acc))))
    (let ((_ (sort (list->vector (helper (quotient len 2) len 1)) <)))
      (foldl
        (lambda (acc i)
          (max (* i (search _ (quotient limit i))) acc))
        0 (helper 0 (quotient len 2) 1)))))

(print (modulo (solve 190) #e1e16))
