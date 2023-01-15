(import
  (chicken sort)
  (euler))

(define digits
  (map integer->char
    (range (char->integer #\0)
           (char->integer #\9))))

(define (solve n)
  (list-ref (sort (map list->string (permutations digits)) string<?) (- n 1)))

(let ((_ (solve #e1e6)))
  (print _) (assert (string=? _ "2783915460")))
