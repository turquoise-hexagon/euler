(import
  (chicken io)
  (chicken string)
  (srfi 1))

(define (import-input)
  (let ((base (char->integer #\A)))
    (map
      (lambda (str)
        (apply +
          (map
            (lambda (char)
              (- (char->integer char) base -1))
            (string->list str))))
      (string-split (read-line) "\","))))

(define (triangle? n)
  (integer? (sqrt (+ (* 8 n) 1))))

(define (solve input)
  (count triangle? input))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 162)))
