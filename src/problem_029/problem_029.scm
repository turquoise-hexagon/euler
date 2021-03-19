(import (srfi 1)
        (srfi 69))

(define (solve x y)
  (let ((hash (make-hash-table)) (lst (iota (- y x -1) x)))
    (for-each
      (lambda (a)
        (for-each
          (lambda (b)
            (hash-table-set! hash (expt a b) 0))
          lst))
      lst)
    (length (hash-table-keys hash))))

(print (solve 2 100))
