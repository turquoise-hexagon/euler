(import (chicken io)
        (chicken irregex))

(define (read-file name)
  (call-with-input-file name
    (lambda (file)
      (do ((line (read-line file) (read-line file))
           (acc (list) (cons (map string->number (irregex-split "," line)) acc)))
        ((eof-object? line) (reverse acc))))))

(define (main name)
  (let ((lst (read-file name)))
    (let helper ((lst lst) (num 1) (acc 0) (cur (car lst)))
      (if (null? lst)
          acc
          (let* ((tmp (car lst))
                 (val (> (* (cadr tmp) (log (car tmp)))
                         (* (cadr cur) (log (car cur))))))
            (helper (cdr lst)
                   (add1 num)
                   (if val num acc)
                   (if val tmp cur)))))))

(display (main "list.txt"))
(newline)
