(import (chicken io)
        (chicken string))

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
        (vector-set! (vector-ref grid (sub1 size)) x
                     (+ (vector-ref (vector-ref grid (sub1 size)) x)
                        (vector-ref (vector-ref grid (sub1 size)) (add1 x))))
        (vector-set! (vector-ref grid x) (sub1 size)
                     (+ (vector-ref (vector-ref grid x) (sub1 size))
                        (vector-ref (vector-ref grid (add1 x)) (sub1 size))))))
    (do ((x (- size 2) (sub1 x))) ((< x 0))
      (do ((y (- size 2) (sub1 y))) ((< y 0))
        (vector-set! (vector-ref grid x) y
                     (+ (vector-ref (vector-ref grid x) y)
                        (min (vector-ref (vector-ref grid (add1 x)) y)
                             (vector-ref (vector-ref grid x) (add1 y)))))))
    (vector-ref (vector-ref grid 0) 0)))

(display (main))
(newline)
