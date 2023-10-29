(import
  (euler)
  (srfi 1))

(define bound/1
  (let loop ((i 1))
    (let ((_ (+ i 1)))
      (if (> (integer-log (expt _ _)) _)
        i
        (loop _)))))

(define bound/2
  (apply max
    (map
      (lambda (n)
        (let loop ((i 1))
          (let ((_ (+ i 1)))
            (if (> (integer-log (expt n _)) bound/1)
              i
              (loop _)))))
      (range 2 bound/1))))

(define (solve)
  (count
    (lambda (pair)
      (apply
        (lambda (i power)
          (let ((_ (expt i power)))
            (= (integer-log _) power)))
        pair))
    (product (range 1 bound/1) (range 1 bound/2))))

(let ((_ (solve)))
  (print _) (assert (= _ 49)))
