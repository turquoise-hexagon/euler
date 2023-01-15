(import
  (euler)
  (srfi 69))

(define (solve n)
  (hash-table-size
    (alist->hash-table
      (map
        (lambda (i)
          (cons (apply expt i) #t))
        (power (range 2 n) 2)))))

(let ((_ (solve 100)))
  (print _) (assert (= _ 9183)))
