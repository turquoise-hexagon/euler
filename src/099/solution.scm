(import
  (chicken io)
  (chicken string)
  (euler))

(define (import-input)
  (let ((lst (read-lines)))
    (map
      (lambda (str index)
        (let ((_ (map string->number (string-split str ","))))
          (cons index _)))
      lst (range 1 (length lst)))))

(define (solve input)
  (car
    (extremum input
      (lambda (lst)
        (apply
          (lambda (_ a b)
            (* b (log a)))
          lst))
      >)))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 709)))
