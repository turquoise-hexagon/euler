(import
  (chicken io)
  (chicken string)
  (euler)
  (srfi 1))

(define offsets
  (delete '(0 0) (power '(-1 0 1) 2)))

(define (import-input)
  (list->array
    (map
      (lambda (str)
        (map string->number
          (string-split str " ")))
      (read-lines))))

(define (neighbors array coord offset)
  (let ((coords
          (foldl
            (lambda (acc _)
              (cons (map + offset (car acc)) acc))
            (list coord) '(_ _ _))))
    (if (every
          (lambda (coord)
            (array-exists? array coord))
          coords)
      coords
      #f)))

(define (get-product array coords)
  (apply *
    (map
      (lambda (coord)
        (array-ref array coord))
      coords)))

(define (solve input)
  (apply max
    (map
      (lambda (coords)
        (get-product input coords))
      (join
        (map
          (lambda (coord)
            (filter-map
              (lambda (offset)
                (neighbors input coord offset))
              offsets))
          (array-indexes input))))))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 70600674)))
