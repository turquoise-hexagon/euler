(import
  (chicken sort)
  (euler))

(define (divisors-count n)
  (apply * (map add1 (map car (run-length (factors n))))))

(define (function n)
  (let ((_ (expt 10 n)))
    (let loop ((lst (sort (divisors _) <)) (acc 0))
      (if (null? lst)
        acc
        (let subloop ((sublst lst) (subacc 0))
          (if (null? sublst)
            (loop (cdr lst) (+ acc subacc))
            (let ((a (car lst))
                  (b (car sublst)))
              (if (> (* a b) _)
                (loop (cdr lst) (+ acc subacc))
                (subloop (cdr sublst)
                  (if (= (gcd a b) 1)
                    (+ subacc (divisors-count (quotient (* _ (+ a b)) (* a b))))
                    subacc))))))))))

(define (solve n)
  (do ((i 1 (+ i 1))
       (acc 0 (+ acc (function i))))
    ((> i n) acc)))

(let ((_ (solve 9)))
  (print _) (assert (= _ 53490)))
