(import
  (chicken io)
  (chicken string)
  (euler)
  (srfi 1))

(define offsets
  (delete '(0 0) (combinations '(-1 0 1) 2)))

(define (import-input)
  (list->array
    (map
      (lambda (str)
        (map string->number (string-split str " ")))
      (read-lines))))

(define (neighbors array coord offset)
  (let ((tmp (foldl
               (lambda (acc _)
                 (cons (map + (car acc) offset) acc))
               (list coord) '(_ _ _))))
    (if (every
          (lambda (coord)
            (array-exists? array coord))
          tmp)
      tmp
      #f)))

(define (helper array lst)
  (apply *
    (map
      (lambda (coord)
        (array-ref array coord))
      lst)))

(define (solve input)
  (apply max
    (map
      (lambda (lst)
        (helper input lst))
      (join
        (map
          (lambda (offset)
            (filter-map
              (lambda (coord)
                (neighbors input coord offset))
              (array-indexes input)))
          offsets)))))

(let ((input (import-input)))
  (print (solve input)))
