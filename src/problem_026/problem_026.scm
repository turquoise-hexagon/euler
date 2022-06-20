(import
  (chicken sort)
  (euler))

(define (solve n)
  (caar
    (sort
      (map
        (lambda (i)
          (cons i (discrete-log 10 1 i)))
        (range 1 n))
      (lambda (a b)
        (> (cdr a)
           (cdr b))))))

(print (solve 1000))
