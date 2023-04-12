(import
  (chicken time posix)
  (euler)
  (srfi 1))

(define (function d m y)
  (time->string
    (string->time
      (string-append
        (number->string d) " "
        (number->string m) " "
        (number->string y))
      "%d %m %Y")
    "%A"))

(define (solve)
  (count
    (lambda (s)
      (string=? s "Sunday"))
    (map
      (lambda (l)
        (apply function l))
      (product (list 1) (range 1 12) (range 1901 2000)))))

(let ((_ (solve)))
  (print _) (assert (= _ 171)))
