(import
  (euler)
  (srfi 1))

(define (f a b)
  (let ((_ (- b a)))
    (foldl
      (lambda (acc i)
        (min (modulo (- a) i) acc))
      _ (delete-duplicates (factors _)))))

(define (solve n)
  (let loop ((a 4) (b 13))
    (let* ((a (+ a 1))
           (_ (f a b))
           (a (+ a _))
           (b (+ b _)))
      (if (> a n)
        (- b (- a n 1))
        (loop a (+ b (gcd a b)))))))

(let ((_ (solve #e1e15)))
  (print _) (assert (= _ 2744233049300770)))
