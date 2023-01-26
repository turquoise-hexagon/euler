(import
  (chicken io)
  (chicken string)
  (chicken fixnum)
  (euler)
  (srfi 1))

(define (import-input)
  (map string->number (string-split (read-line) ",")))

(define (solve input)
  (let ((a (char->integer #\a))
        (z (char->integer #\z))
        (s (char->integer #\ )))
    (foldl fx+ 0
      (extremum
        (map
          (lambda (key)
            (map fxxor input (apply circular-list key)))
          (power (range a z) 3))
        (lambda (lst)
          (count
            (lambda (i)
              (fx= i s))
            lst))
        fx>))))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 129448)))
