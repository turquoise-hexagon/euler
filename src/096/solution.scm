(import
  (chicken fixnum)
  (chicken io)
  (chicken irregex)
  (chicken string))

(define-constant SIZE 9)

(define-syntax grid-ref
  (syntax-rules ()
    ((_ grid x y)
     (vector-ref (vector-ref grid x) y))))

(define-syntax grid-set!
  (syntax-rules ()
    ((_ grid x y n)
     (vector-set! (vector-ref grid x) y n))))

(define (parse-chunk chunk)
  (list->vector
    (map
      (lambda (str)
        (list->vector (map string->number (string-chop str 1))))
      (string-split chunk "\n"))))

(define (import-input)
  (map parse-chunk (irregex-split "Grid [0-9]+\n" (read-string))))

(define (find-empty? grid)
  (call/cc
    (lambda (_)
      (do ((i 0 (fx+ i 1))) ((fx= i SIZE))
        (do ((j 0 (fx+ j 1))) ((fx= j SIZE))
          (when (fx= (grid-ref grid i j) 0)
            (_ (list i j)))))
      #f)))

(define (can-place? grid x y n)
  (call/cc
    (lambda (_)
      (unless (fx= (grid-ref grid x y) 0)
        (_ #f))

      (do ((i 0 (fx+ i 1))) ((fx= i SIZE))
        (when (fx= (grid-ref grid i y) n)
          (_ #f)))
      (do ((i 0 (fx+ i 1))) ((fx= i SIZE))
        (when (fx= (grid-ref grid x i) n)
          (_ #f)))

      (let ((a (fx- x (fxmod x 3)))
            (b (fx- y (fxmod y 3))))
        (do ((i a (fx+ i 1))) ((fx= i (fx+ a 3)))
          (do ((j b (fx+ j 1))) ((fx= j (fx+ b 3)))
            (when (fx= (grid-ref grid i j) n)
              (_ #f)))))

      #t)))

(define (solve-sudoku! grid)
  (call/cc
    (lambda (_)
      (let ((result (find-empty? grid)))
        (if result
          (apply
            (lambda (x y)
              (do ((i 1 (fx+ i 1))) ((fx> i SIZE))
                (when (can-place? grid x y i)
                  (grid-set! grid x y i)
                  (when (solve-sudoku! grid)
                    (_ #t))
                  (grid-set! grid x y 0)))
              #f)
            result)
          #t)))))

(define (get-value grid)
  (do ((i 0 (fx+ i 1))
       (acc 0 (fx+ (fx* acc 10) (grid-ref grid 0 i))))
    ((fx= i 3) acc)))

(define (solve input)
  (for-each solve-sudoku! input)
  (foldl fx+ 0 (map get-value input)))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 24702)))
