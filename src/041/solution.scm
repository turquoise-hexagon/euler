(import
  (euler)
  (srfi 1))

(define (solve)
  (apply max (filter prime? (map list->number (append-map permutations (map (lambda (_) (iota _ 1)) (iota 9 1)))))))

(let ((_ (solve)))
  (print _) (assert (= _ 7652413)))
