(import
  (chicken sort)
  (euler)
  (srfi 1))

(define (rad n)
  (apply * (delete-duplicates (factorize n) =)))

(define (solve a b)
  (let ((_ (sort
             (map
               (lambda (i)
                 (cons i (rad i)))
               (range 1 a))
             (lambda (a b)
               (< (cdr a)
                  (cdr b))))))
    (car (list-ref _ (- b 1)))))

(let ((_ (solve #e1e5 #e1e4)))
  (print _) (assert (= _ 21417)))
