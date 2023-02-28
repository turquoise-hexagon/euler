(import
  (chicken sort)
  (euler)
  (srfi 69))

(define (id n)
  (list->string (sort (string->list (number->string n)) char<?)))

(define (solve n)
  (let ((mem (make-hash-table)))
    (let loop ((i 1))
      (let* ((value (* i i i))
             (acc (hash-table-update!/default mem (id value)
                    (lambda (_)
                      (cons value _))
                    '())))
        (if (= (length acc) n)
          (apply min acc)
          (loop (+ i 1)))))))

(let ((_ (solve 5)))
  (print _) (assert (= _ 127035954683)))
