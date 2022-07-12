(define (pentagonal? n) (integer? (/ (+ (sqrt (+ (* 24 n) 1)) 1) 6)))
(define ( hexagonal? n) (integer? (/ (+ (sqrt (+ (*  8 n) 1)) 1) 4)))

(define (solve)
  (let loop ((i 286))
    (let ((_ (/ (* i (+ i 1)) 2)))
      (if (and (pentagonal? _)
               ( hexagonal? _))
        _
        (loop (+ i 1))))))

(print (solve))
