(import (chicken io)
        (chicken string)
        (chicken sort)
        (matchable)
        (srfi 1))

(define (import-input)
  (map (cut map string->number <>) (map (cut string-split <> ",") (read-lines))))

(define (generate-list input)
  (fold
    (lambda (a b acc)
      (cons (list a b) acc))
    '() (iota (length input) 1) input))

(define (solve input)
  (let ((lst (generate-list input)))
    (caar (sort lst (lambda (a b)
                      (match-let
                        (((_ (i j)) a)
                         ((_ (k l)) b))
                        (> (* j (log i))
                           (* l (log k)))))))))

(print (solve (import-input)))
