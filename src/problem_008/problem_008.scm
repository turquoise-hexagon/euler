(import (chicken io)
        (srfi 1))

(define (import-input)
  (map string->number (map string (append-map (cut string->list <>) (read-lines (open-input-file "input"))))))

(define (get-sequences lst n)
  (let get-sequences/h ((lst lst) (acc '()))
    (if (< (length lst) 13)
        acc
        (get-sequences/h (cdr lst) (cons (take lst n) acc)))))

(define (solve n)
  (apply max (map (cut apply * <>) (get-sequences (import-input) n))))

(print (solve 13))
