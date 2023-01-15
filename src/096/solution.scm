(import
  (chicken io)
  (chicken string)
  (chicken irregex)
  (matchable)
  (srfi 1))

(define X 9)
(define Y 9)

(define (find-empty grid)
  (call/cc
    (lambda (return)
      (for-each
        (lambda (i)
          (for-each
            (lambda (j)
              (when (= (vector-ref (vector-ref grid i) j) 0)
                (return (list i j))))
            (iota Y)))
        (iota X))
      #f)))

(define (can-place? grid x y n)
  (call/cc
    (lambda (return)
      (for-each (lambda (i) (when (= (vector-ref (vector-ref grid i) y) n) (return #f))) (iota X))
      (for-each (lambda (i) (when (= (vector-ref (vector-ref grid x) i) n) (return #f))) (iota Y))
      (for-each
        (lambda (i)
          (for-each
            (lambda (j)
              (when (= (vector-ref (vector-ref grid i) j) n)
                (return #f)))
            (iota 3 (- y (modulo y 3)))))
        (iota 3 (- x (modulo x 3))))
      (= (vector-ref (vector-ref grid x) y) 0))))

(define (solve-sudoku grid)
  (call/cc
    (lambda (return)
      (match (find-empty grid)
        ((x y)
         (for-each
           (lambda (i)
             (when (can-place? grid x y i)
               (vector-set! (vector-ref grid x) y i)
               (when (solve-sudoku grid)
                 (return #t))
               (vector-set! (vector-ref grid x) y 0)))
           (iota X 1))
         #f)
        (_ #t)))))

(define (get-value grid)
  (let ((lst (vector->list (vector-ref grid 0))))
    (let ((lst (map number->string (take lst 3))))
      (string->number (apply string-append lst)))))

(define (import-input)
  (map
    (lambda (str)
      (list->vector (map
                      (lambda (str)
                        (list->vector (map string->number (string-chop str 1))))
                      (string-split str "\n"))))
   (irregex-split "Grid [0-9]+\n" (read-string #f))))

(define (solve input)
  (for-each solve-sudoku input)
  (apply + (map get-value input)))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 24702)))
