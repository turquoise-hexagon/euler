(import
  (chicken io)
  (chicken irregex))

(define (import-input)
  (read-lines))

(define (minimize str)
  (irregex-replace/all "(DCCCC|LXXXX|VIIII|CCCC|XXXX|IIII)" str "  "))

(define (solve input)
  (- (apply + (map string-length input))
     (apply + (map string-length (map minimize input)))))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 743)))
