(import
  (euler))

(define (solve n)
  (list->number (list-ref (permutations (range 0 9)) (- n 1))))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 2783915460)))
