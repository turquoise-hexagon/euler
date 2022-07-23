(import
  (chicken io)
  (chicken sort)
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
  (let ((_ (sort input
             (lambda (a b)
               (let-values
                 (((_ i j) (apply values a))
                  ((_ k l) (apply values b)))
                 (> (* j (log i))
                    (* l (log k))))))))
    (caar _)))

(let ((input (import-input)))
  (print (solve input)))
