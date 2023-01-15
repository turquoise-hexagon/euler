(import
  (chicken irregex)
  (format)
  (euler))

(define (helper n)
  (let ((_ (irregex-replace/all "[^a-z]" (format "~r" n) "")))
    (+ (string-length _)
       ;; take "and" into account
       (if (and (> n 100) (> (modulo n 100) 0))
         3
         0))))

(define (solve n)
  (apply + (map helper (range 1 1000))))

(let ((_ (solve 1000)))
  (print _) (assert (= _ 21124)))
