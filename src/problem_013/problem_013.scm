(import (chicken io)
        (srfi 1))

(define (number->list n)
  (map
    (cut - <> (char->integer #\0))
    (map char->integer (string->list (number->string n)))))

(define (import-input)
  (map string->number (read-lines (open-input-file "input"))))

(define (solve n)
  (apply string-append (map number->string (take (number->list (apply + (import-input))) n))))

(print (solve 10))
