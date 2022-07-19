(import
  (chicken bitwise)
  (chicken io)
  (chicken string)
  (chicken sort)
  (euler)
  (srfi 1))

(define CHARS 
  (let ((base (char->integer #\a)))
    (range base (+ base 26))))

(define (import-input)
  (map string->number (string-split (read-line) ",")))

(define (translate input key)
  (map bitwise-xor input (apply circular-list key)))

(define (count-spaces lst)
  (let ((space (char->integer #\ )))
    (count
      (lambda (i)
        (= i space))
      lst)))

(define (helper input len)
  (map
    (lambda (key)
      (let ((tmp (translate input key)))
        (list (count-spaces tmp) (apply + tmp))))
    (power CHARS len)))

(define (solve input len)
  (cadar
    (sort (helper input len)
      (lambda (a b)
        (> (car a)
           (car b))))))

(let ((input (import-input)))
  (print (solve input 3)))
