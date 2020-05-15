(import (chicken io)
        (chicken string))

(define triangles
  (do ((x 0 (add1 x))
       (acc (list) (cons (quotient (* x (add1 x)) 2) acc)))
    ((= x 100) acc)))

(define (triangle? n)
  (member n triangles))

(define (read-file name)
  (call-with-input-file name
    (lambda (file)
      (map
        (lambda (str)
          (substring str 1 (sub1 (string-length str))))
        (string-split (read-line file) ",")))))

(define (string-value str)
  (apply +
    (map
      (lambda (char)
        (- (char->integer char) 64))
      (string->list str))))

(define (main)
  (do ((lst (read-file "list.txt") (cdr lst))
       (acc 0 (if (triangle? (string-value (car lst)))
                  (add1 acc)
                  acc)))
    ((null? lst) acc)))

(display (main))
(newline)
