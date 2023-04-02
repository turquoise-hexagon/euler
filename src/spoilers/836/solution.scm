(import
  (chicken io)
  (chicken irregex))

(define-constant regex "<b>([a-z ]+)</b>")

(define (import-input)
  (join
    (map
      (lambda (str)
        (irregex-split " " (irregex-match-substring (irregex-match regex str) 1)))
      (irregex-extract regex (read-string)))))

(define (solve input)
  (list->string (map car (map string->list input))))

(let ((input (import-input)))
  (let ((_ (solve input)))
    (print _) (assert (string=? _ "aprilfoolsjoke"))))
