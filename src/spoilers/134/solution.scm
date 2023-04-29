(import
  (euler))

(define (next-prime p l n)
  (let ((t (+ n 1)))
    (if (< t l)
      (vector-ref p t)
      (do ((i (+ (vector-ref p n) 1) (+ i 1)))
        ((prime? i) i)))))

(define (order n)
  (do ((i 1 (* i 10)))
    ((> i n) i)))

(define (function p l n)
  (let ((t (vector-ref p n)))
    (solve-chinese (list t 0) (list (order t) (next-prime p l n)))))

(define (solve n)
  (let* ((p (list->vector (list-tail (primes n) 2))) (l (vector-length p)))
    (do ((i 0 (+ i 1))
         (acc 0 (+ acc (function p l i))))
      ((= i l) acc))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 18613426663617118)))
