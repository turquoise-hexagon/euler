(import euler
        (chicken sort))

(define (main n)
  (let* ((bound-number (expt 10 15))
         (bound-digits (do ((x bound-number (quotient x 10))
                            (acc 0 (+ acc 9)))
                         ((zero? x) acc))))
    (list-ref (sort
                (do ((x 2 (add1 x))
                     (acc (list) (do ((y (* x x) (* y x))
                                      (acc acc (if (= (digitsum y) x)
                                                   (cons y acc)
                                                   acc)))
                                   ((> y bound-number) acc))))
                  ((> x bound-digits) acc))
                <)
              (sub1 n))))

(display (main 30))
(newline)
