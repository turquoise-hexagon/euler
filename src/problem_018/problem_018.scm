(import
  (chicken io)
  (chicken string)
  (chicken condition)
  (euler)
  (srfi 1)
  (srfi 69))

(define offsets '((1 0) (1 1)))

(define (neighbors array coord)
  (filter
    (lambda (coord)
      (condition-case (foldl vector-ref array coord)
        ((exn) #f)))
    (map
      (lambda (offset)
        (map + coord offset))
      offsets)))

(define (import-input)
  (list->vector
    (map
      (lambda (str)
        (list->vector (map string->number (string-split str " "))))
      (read-lines))))

(define (comp? a b)
  (> (car a)
     (car b)))

(define (helper! array table queue cost coord)
  (foldl
    (lambda (queue coord)
      (let ((cost (+ cost (foldl vector-ref array coord))))
        (if (> cost (hash-table-ref/default table coord -inf.0))
          (begin
            (hash-table-set! table coord cost)
            (priority-queue-insert comp? `(,cost ,coord) queue))
          queue)))
    (priority-queue-rest comp? queue) (neighbors array coord)))

(define (solve input)
  (let ((acc (make-hash-table)))
    (let loop ((queue (priority-queue-insert comp? `(,(foldl vector-ref input '(0 0)) (0 0)) priority-queue-empty)))
      (if (priority-queue-empty? queue)
        (apply max (hash-table-values acc))
        (apply
          (lambda (cost coord)
            (loop (helper! input acc queue cost coord)))
          (priority-queue-first queue))))))

(let ((input (import-input)))
  (print (solve input)))
