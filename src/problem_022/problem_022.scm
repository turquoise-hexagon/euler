(import (chicken io)
        (chicken string)
        (chicken sort)
        (srfi 1))

(define (import-input)
  (string-split (read-line (open-input-file "input")) ",\""))

(define (get-value str)
  (apply + (map (cut - <> (char->integer #\A) -1) (map char->integer (string->list str)))))

(define (solve)
  (let ((lst (sort (import-input) string<?)))
    (fold
      (lambda (a b acc)
        (+ (* b (get-value a)) acc))
      0 lst (iota (length lst) 1))))

(print (solve))
