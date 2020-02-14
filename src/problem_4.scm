(import (euler)
        (srfi 1))

(define (main)
  (apply max (filter palindrome? (do ((x 999 (sub1 x))
                                      (acc (list) (do ((y 999 (sub1 y))
                                                       (acc acc (cons (* x y) acc)))
                                                    ((< y 100) acc))))
                                   ((< x 100) acc)))))

(display (main))
