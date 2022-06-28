(import
  (chicken io)
  (chicken string)
  (chicken sort)
  (srfi 1))

(define (import-input)
  (string-split (read-line) "\","))

(define (convert str)
  (let ((base (- (char->integer #\A) 1)))
    (apply +
      (map
        (lambda (i)
          (- (char->integer i) base))
        (string->list str)))))

(define (solve input)
  (let ((lst (sort input string<?)))
    (fold
      (lambda (value index acc)
        (+ acc (* (convert value) index)))
      0 lst (iota (length lst) 1))))

(let ((input (import-input)))
  (print (solve input)))
