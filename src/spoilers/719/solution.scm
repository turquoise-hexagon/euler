(import
  (euler))

(define (S? n)
  (let main ((root n) (square (* n n)))
    (cond
      ((> root square) #f)
      ((= root square) #t)
      (else
        (let loop ((i 10))
          (let ((q (quotient square i)) (m (modulo square i)))
            (if (> square i)
              (if (and (> root m) (main (- root m) q))
                #t
                (loop (* i 10)))
              #f)))))))

(define (solve n)
  (let ((n (sqrt n)))
    (let loop ((i 2) (acc 0))
      (if (> i n)
        acc
        (loop (+ i 1)
          (if (S? i)
            (+ acc (* i i))
            acc))))))

(let ((_ (solve 1e12)))
  (print _) (assert (= _ 128088830547982)))
