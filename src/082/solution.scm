(import
  (chicken io)
  (chicken string)
  (euler)
  (srfi 1)
  (srfi 69))

(define-constant offsets
  '((-1 0)
    ( 1 0)
    ( 0 1)))

(define (import-input)
  (list->array
    (map
      (lambda (str)
        (map string->number (string-split str ",")))
      (read-lines))))

(define (neighbors array coord)
  (filter
    (lambda (coord)
      (array-exists? array coord))
    (map
      (lambda (offset)
        (map + coord offset))
      offsets)))

(define (compare? a b)
  (< (car a)
     (car b)))

(define (find-path array froms tos)
  (let ((acc (make-hash-table)))
    (let loop ((queue (list->priority-queue (map (lambda (coord) (list (array-ref array coord) coord)) froms) compare?)))
      (if (priority-queue-empty? queue)
        (apply min (map (lambda (coord) (hash-table-ref acc coord)) tos))
        (loop
          (apply
            (lambda (cost coord)
              (foldl
                (lambda (queue coord)
                  (let ((cost (+ cost (array-ref array coord))))
                    (if (> (hash-table-ref/default acc coord +inf.0) cost)
                      (begin
                        (hash-table-set! acc coord cost)
                        (priority-queue-insert queue (list cost coord)))
                      queue)))
                (priority-queue-rest queue) (neighbors array coord)))
            (priority-queue-first queue)))))))

(define (solve input)
  (apply
    (lambda (h w)
      (let ((a (- h 1)) (b (- w 1)))
        (find-path input
          (map (lambda (i) (list i 0)) (range 0 a))
          (map (lambda (i) (list i b)) (range 0 a)))))
    (array-dimensions input)))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 260324)))
