(import
  (euler)
  (srfi 69))

(define (solve n)
  (hash-table-size
    (alist->hash-table
      (map
        (lambda (i)
          (cons (apply expt i) #t))
        (combinations (range 2 n) 2)))))

(print (solve 100))
