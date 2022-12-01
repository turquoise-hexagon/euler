(import
  (euler))

(define (pentagonal n)
  (/ (* n (- (* 3 n) 1)) 2))

(define (pentagonal? n)
  (integer? (/ (+ (sqrt (+ (* 24 n) 1)) 1) 6)))

(define (solve)
  (call/cc
    (lambda (_)
      (let loop ((i 1))
        (let ((a (pentagonal i)))
          (for-each
            (lambda (j)
              (let ((b (pentagonal j)))
                (when (and (pentagonal? (+ a b))
                           (pentagonal? (- a b)))
                  (_ (abs (- a b))))))
            (range 1 i)))
        (loop (+ i 1))))))

(print (solve))
