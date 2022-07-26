(import
  (chicken io)
  (chicken string)
  (matchable)
  (srfi 1))

(define (import-input)
  (map
    (lambda (str)
      (map
        (lambda (_)
          (apply list _))
        (let ((_ (string-split str ",")))
          (chop (map string->number _) 2))))
    (read-lines)))

(define (sign a b c)
  (match-let
    (((x/a y/a) a)
     ((x/b y/b) b)
     ((x/c y/c) c))
    (- (* (- x/a x/c) (- y/b y/c))
       (* (- x/b x/c) (- y/a y/c)))))

(define (in-triangle? p triangle)
  (apply
    (lambda (a b c)
      (let ((_ (list (sign p a b)
                     (sign p b c)
                     (sign p c a))))
        (not (and (any > _ '(0 0 0))
                  (any < _ '(0 0 0))))))
    triangle))

(define (solve input)
  (let ((origin '(0 0)))
    (count
      (lambda (_)
        (in-triangle? origin _))
      input)))

(let ((input (import-input)))
  (print (solve input)))
