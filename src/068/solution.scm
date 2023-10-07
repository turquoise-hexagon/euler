(import
  (euler)
  (srfi 1))

(define-constant l
  '((0 6 7)
    (1 7 8)
    (2 8 9)
    (3 9 5)
    (4 5 6)))

(define (constraint?/1 v)
  (= (min (vector-ref v 0)
          (vector-ref v 1)
          (vector-ref v 2)
          (vector-ref v 3)
          (vector-ref v 4))
     (vector-ref v 0)))

(define (constraint?/2 v)
  (apply =
    (map
      (lambda (_)
        (apply +
          (map
            (lambda (_)
              (vector-ref v _))
            _)))
      l)))

(define (valid? v)
  (and (constraint?/1 v)
       (constraint?/2 v)))

(define (value v)
  (apply string-append
    (map
      (lambda (_)
        (apply string-append
          (map
            (lambda (_)
              (number->string (vector-ref v _)))
            _)))
      l)))

(define (solve)
  (apply max
    (map string->number
      (filter
        (lambda (_)
          (= (string-length _) 16))
        (map value
          (filter valid?
            (map list->vector
              (permutations (range 1 10)))))))))

(let ((_ (solve)))
  (print _) (assert (= _ 6531031914842725)))
