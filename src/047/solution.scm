(import
  (euler)
  (srfi 1))

(define (number-distinct-prime-factors n)
  (length (delete-duplicates (factorize n) =)))

(define (helper i n)
  (let loop ((i i) (acc 0))
    (if (= (number-distinct-prime-factors i) n)
      (loop (+ i 1) (+ acc 1))
      acc)))

(define (solve n)
  (let loop ((i 1))
    (let ((t (helper i n)))
      (if (= t n)
        i
        (loop (+ i (max 1 t)))))))

(let ((_ (solve 4)))
  (print _) (assert (= _ 134043)))
