(import
  (euler)
  (srfi 1))

(define-constant divs
  '(2 3 5 7 11 13 17))

(define (valid? lst)
  (let loop ((lst (cdr lst)) (divs divs))
    (if (null? divs)
      #t
      (let ((_ (list->number (take lst 3))))
        (if (= (modulo _ (car divs)) 0)
          (loop (cdr lst) (cdr divs))
          #f)))))

(define (solve)
  (apply + (map list->number (filter valid? (permutations (range 9))))))

(let ((_ (solve)))
  (print _) (assert (= _ 16695334890)))
