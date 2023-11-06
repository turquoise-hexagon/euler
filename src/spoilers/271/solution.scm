(import
  (euler))

(define (s n)
  (do ((i 1 (+ i 1))
       (acc '() (if (= (modular-expt i 3 n) 1)
                  (cons i acc)
                  acc)))
    ((> i n) acc)))

(define (solve n)
  (let ((factors (factors n)))
    (- (apply +
         (map
           (lambda (solution)
             (chinese-remainder-theorem solution factors))
           (apply product (map s factors))))
       1)))

(let ((_ (solve 13082761331670030)))
  (print _) (assert (= _ 4617456485273129588)))
