(import (chicken io)
        (chicken string)
        (srfi 1))

(define (import-input)
  (string-split (read-line) "\","))

(define (get-value str)
  (let ((base (char->integer #\A)))
    (apply + (map
               (lambda (i)
                 (- (char->integer i) base -1))
               (string->list str)))))

(define (triangle n)
  (* 1/2 n (+ n 1)))

(define (triangles n)
  (map triangle (iota n)))

(define (solve input)
  (let ((triangles (triangles 100)))
    (count (cut member <> triangles) (map get-value input))))

(let ((input (import-input)))
  (print (solve input)))
