(import
  (chicken bitwise)
  (chicken io)
  (chicken string)
  (euler)
  (srfi 1))

(define chars
  (let ((base (char->integer #\a)))
    (range base (+ base 26))))

(define (import-input)
  (map string->number (string-split (read-line) ",")))

(define (translate lst key)
  (map bitwise-xor lst (apply circular-list key)))

(define (translate-all lst len)
  (map
    (lambda (key)
      (translate lst key))
    (power chars len)))

(define (count-spaces lst)
  (let ((space (char->integer #\space)))
    (count (lambda (_) (= _ space)) lst)))

(define (solve input len)
  (apply + (extremum (translate-all input len) count-spaces >)))

(let ((_ (solve (import-input) 3)))
  (print _) (assert (= _ 129448)))
