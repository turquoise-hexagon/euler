(import
  (euler)
  (srfi 1))

(define pattern
  '(1 _ 2 _ 3 _ 4 _ 5 _ 6 _ 7 _ 8 _ 9 _ 0))

(define (generate-bound)
  (list->number
    (map
      (lambda (i)
        (if (number? i) i 9))
      pattern)))

(define (generate-fixed-bound)
  (let ((_ (inexact->exact (round (sqrt (generate-bound))))))
    (- _ (modulo _ 10))))

(define (valid? n)
  (every
    (lambda (digit match)
      (if (number? match)
        (= digit match)
        #t))
    (number->list n) pattern))

(define (solve)
  (let loop ((i (generate-fixed-bound)))
    (if (valid? (* i i))
      i
      (loop (- i 10)))))

(let ((_ (solve)))
  (print _) (assert (= _ 1389019170)))
