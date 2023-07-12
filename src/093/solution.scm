(import
  (euler)
  (srfi 69))

(define operators (list + - * /))

(define (run lst)
  (let ((acc (make-hash-table)))
    (let loop ((lst lst))
      (if (and (null? (cdr lst)) (integer? (car lst)))
        (hash-table-set! acc (car lst) #t)
        (for-each
          (lambda (pair)
            (apply
              (lambda (a b)
                (let* ((lst (delete-first lst a))
                       (lst (delete-first lst b)))
                  (for-each
                    (lambda (operator)
                      (let ((i (operator a b)))
                        (when (> i 0)
                          (loop (cons i lst)))))
                    operators)))
              pair))
          (let ((pairs (combinations lst 2)))
            (append pairs (map reverse pairs))))))
    acc))

(define (value lst)
  (let ((acc (run lst)))
    (let loop ((i 1))
      (if (hash-table-exists? acc i)
        (loop (+ i 1))
        (- i 1)))))

(define (solve nb-digits)
  (list->number (extremum (combinations (range 1 9) nb-digits) value >)))

(let ((_ (solve 4)))
  (print _) (assert (= _ 1258)))
