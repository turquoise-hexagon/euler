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

(print (solve (import-input)))
