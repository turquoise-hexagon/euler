(import
  (chicken io)
  (chicken string)
  (chicken sort)
  (euler))

(define (import-input)
  (let ((base (char->integer #\A)))
    (map
      (lambda (str)
        (apply +
          (map
            (lambda (char)
              (- (char->integer char) base -1))
            (string->list str))))
      (sort (string-split (read-line) "\",") string<?))))

(define (solve input)
  (apply + (map * input (range 1 (length input)))))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 871198282)))
