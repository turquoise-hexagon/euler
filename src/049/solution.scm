(import
  (chicken sort)
  (euler)
  (srfi 1))

(define (helper number start stop)
  (filter
    (lambda (i)
      (and (<= start i stop) (prime? i)))
    (delete-duplicates
      (map list->number (permutations (number->list number)))
      =)))

(define (generate-sequences number start stop length-sequence)
  (let ((lst (helper number start stop)))
    (if (>= (length lst) length-sequence)
      (filter
        (lambda (i)
          (apply = (map - i (cdr i))))
        (combinations (sort lst <) length-sequence))
      '())))

(define (convert-to-output lst)
  (list->number (join (map number->list lst))))

(define (solve number-digits length-sequence)
  (let ((start (expt 10 (- number-digits 1))) (stop (- (expt 10 number-digits) 1)))
    (convert-to-output
      (second
        (delete-duplicates
          (join
            (filter-map
              (lambda (i)
                (generate-sequences i start stop length-sequence))
              (filter prime? (range start stop))))
          equal?)))))

(let ((_ (solve 4 3)))
  (print _) (assert (= _ 296962999629)))
