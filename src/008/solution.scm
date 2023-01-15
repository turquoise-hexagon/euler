(import
  (chicken io)
  (chicken string)
  (srfi 1))

(define (import-input)
  (map string->number (string-chop (apply string-append (read-lines)) 1)))

(define (solve input n)
  (let loop ((lst input) (acc 0))
    (if (< (length lst) n)
      acc
      (loop (cdr lst)
        (let ((tmp (apply * (take lst n))))
          (if (> tmp acc)
            tmp
            acc))))))

(let ((_ (solve (import-input) 13)))
  (print _) (assert (= _ 23514624000)))
