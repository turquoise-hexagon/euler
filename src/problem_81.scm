(import (chicken io)
        (chicken string))

(define (helper-ref vec . refs)
  (do ((refs refs (cdr refs))
       (vec vec (vector-ref vec (car refs))))
    ((null? refs) vec)))

(define (helper-set vec val . refs)
  (do ((refs refs (cdr refs))
       (vec vec (vector-ref vec (car refs))))
    ((null? (cdr refs)) (vector-set! vec (car refs) val))))

(define (read-file name)
  (call-with-input-file name
    (lambda (file)
      (do ((line (read-line file)
                 (read-line file))
           (acc (list) (cons (list->vector (map string->number
                                                (string-split line ",")))
                             acc)))
        ((eof-object? line) (list->vector (reverse acc)))))))

(define (main)
  (let* ((grid (read-file "list.txt"))
         (size (vector-length grid)))
    (do ((x (- size 2) (sub1 x))) ((< x 0))
      (begin
        (helper-set grid (+ (helper-ref grid (sub1 size) x)
                            (helper-ref grid (sub1 size) (add1 x)))
                    (sub1 size) x)
        (helper-set grid (+ (helper-ref grid x (sub1 size))
                            (helper-ref grid (add1 x) (sub1 size)))
                    x (sub1 size))))
    (do ((x (- size 2) (sub1 x))) ((< x 0))
      (do ((y (- size 2) (sub1 y))) ((< y 0))
        (helper-set grid (+ (helper-ref grid x y)
                            (min (helper-ref grid (add1 x) y)
                                 (helper-ref grid x (add1 y))))
                    x y)))
    (helper-ref grid 0 0)))

(display (main))
(newline)
