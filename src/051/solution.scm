(import
  (euler)
  (srfi 1))

(define digits
  (iota 10))

(define (number-length n)
  (if (> n 0)
    (inexact->exact (ceiling (log n 10)))
    1))

(define (generate-family i n)
  (let ((lst (number->list i)) (len (number-length i)))
    (find
      (lambda (lst)
        ;; look for a valid family
        (= (length lst) n))
      (map
        (lambda (indexes)
          (filter
            (lambda (i)
              ;; remove small / non-primes numbers that got generated
              (and (= (number-length i) len) (prime? i)))
            (map
              (lambda (digit)
                ;; generate the new number
                (let ((tmp (list->vector lst)))
                  (for-each
                    (lambda (index)
                      (vector-set! tmp index digit))
                    indexes)
                  (list->number (vector->list tmp))))
              digits)))
        ;; generate all indexes to edit
        (let ((indexes (iota len)))
          (join
            (map
              (lambda (i)
                (combinations indexes (+ i 1)))
              indexes)))))))

(define (solve n)
  (let loop ((lst (primes 1000000)))
    (let ((tmp (generate-family (car lst) n)))
      (if tmp
        (apply min tmp)
        (loop (cdr lst))))))

(let ((_ (solve 8)))
  (print _) (assert (= _ 121313)))
