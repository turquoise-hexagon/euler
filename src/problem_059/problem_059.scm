(import (chicken io)
        (chicken string)
        (chicken bitwise)
        (chicken sort)
        (matchable)
        (euler)
        (srfi 1))

(define (import-input)
  (map string->number (string-split (read-line) ",")))

(define (count-spaces lst)
  (let ((space (char->integer #\ )))
    (count (cut = space <>) lst)))

(define (decode input key)
  (fold-right
    (lambda (a b acc)
      (cons (bitwise-xor a b) acc))
    '() input (apply circular-list key)))

(define (numbers->string lst)
  (list->string (map integer->char lst)))

(define (solve input)
  (let ((keys (combinations (iota 26 (char->integer #\a)) 3)))
    (let ((sorted (sort (map
                          (lambda (lst)
                            (list (count-spaces lst) lst))
                          (map (cut decode input <>) keys))
                        (lambda (a b)
                          (apply > (map car (list a b)))))))
      (match sorted
        (((_ candidate) . _)
         (list (apply + candidate) (numbers->string candidate)))))))

(let ((input (import-input)))
  (for-each print (solve input)))
