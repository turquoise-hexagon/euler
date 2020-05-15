(import (chicken io)
        (chicken string)
        (chicken sort))

(define (read-file name)
  (call-with-input-file name
    (lambda (file)
      (sort
        (map
          (lambda (str)
            (substring str 1 (sub1 (string-length str))))
          (string-split (read-line file) ","))
        string<?))))

(define (string-value str)
  (apply +
    (map
      (lambda (char)
        (- (char->integer char) 64))
      (string->list str))))

(define (main)
  (do ((x 1 (add1 x))
       (lst (read-file "list.txt") (cdr lst))
       (acc 0 (+ acc (* x (string-value (car lst))))))
    ((null? lst) acc)))

(display (main))
(newline)
