(import
  (chicken sort)
  (euler))

(define digits
  (map integer->char
    (range (char->integer #\0)
           (char->integer #\9))))

(define (solve n)
  (list-ref (sort (map list->string (permutations digits)) string<?) (- n 1)))

(print (solve 1000000))
