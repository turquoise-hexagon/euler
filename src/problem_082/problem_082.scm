(import
  (chicken io)
  (chicken string)
  (euler)
  (srfi 1)
  (srfi 69))

(define offsets
  '(( 1 0)
    ( 0 1)
    (-1 0)))

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
            (priority-queue-insert comp? `(,cost ,coord) queue))
          queue)))
    (priority-queue-rest comp? queue) (neighbors array coord)))

(define (path array from)
  (let ((acc (make-hash-table)))
    (let loop ((queue (list->priority-queue comp? `((,(array-ref array from) ,from)))))
      (if (priority-queue-empty? queue)
        acc
        (apply
          (lambda (cost coord)
            (loop (helper! array acc queue cost coord)))
          (priority-queue-first queue))))))

(define (solve input)
  (apply
    (lambda (h w)
      (let ((r (product (range 0 (- h 1)) (list 0)))
            (l (product (range 0 (- h 1)) (list (- w 1)))))
        (apply min
          (flatten
            (map
              (lambda (r)
                (let ((table (path input r)))
                  (map
                    (lambda (l)
                      (hash-table-ref table l))
                    l)))
              r)))))
    (array-dimensions input)))

(let ((input (import-input)))
  (print (solve input)))
