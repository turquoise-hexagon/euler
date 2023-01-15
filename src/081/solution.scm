(import
  (chicken io)
  (chicken string)
  (euler)
  (srfi 1)
  (srfi 69))

(include-relative "include.scm")

(define (neighbors array coord)
  (filter
    (lambda (coord)
      (array-exists? array coord))
    (map
      (lambda (offset)
        (map + coord offset))
      offsets)))

(define (import-input)
  (list->array
    (map
      (lambda (str)
        (map string->number (string-split str ",")))
      (read-lines))))

(define (comp? a b)
  (< (car a)
     (car b)))

(define (helper! array table queue cost coord)
  (foldl
    (lambda (queue coord)
      (let ((cost (+ cost (array-ref array coord))))
        (if (< cost (hash-table-ref/default table coord +inf.0))
          (begin
            (hash-table-set! table coord cost)
            (priority-queue-insert queue `(,cost ,coord)))
          queue)))
    (priority-queue-rest queue) (neighbors array coord)))

(define (solve input from to)
  (let ((acc (make-hash-table)))
    (let loop ((queue (list->priority-queue `((,(array-ref input from) ,from)) comp?)))
      (if (priority-queue-empty? queue)
        (hash-table-ref acc to)
        (apply
          (lambda (cost coord)
            (loop (helper! input acc queue cost coord)))
          (priority-queue-first queue))))))

(let ((input (import-input)))
  (print (solve input '(0 0) (map + (array-dimensions input) '(-1 -1)))))
