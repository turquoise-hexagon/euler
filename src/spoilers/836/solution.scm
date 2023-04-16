(import
  (chicken io)
  (chicken irregex))

(define (import-input)
  (join
    (map
      (lambda (str)
        (irregex-split "(<b>|</b>| )" str))
      (irregex-extract "<b>[a-z ]+</b>" (read-string)))))

(define (solve input)
  (list->string (map car (map string->list input))))

(let ((_ (solve (import-input))))
  (print _) (assert (string=? _ "aprilfoolsjoke")))
