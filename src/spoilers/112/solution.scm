(import
  (chicken sort)
  (euler))

(define (bouncy? n)
  (let ((tmp (number->list n)))
    (not (or (equal? tmp (sort tmp <))
             (equal? tmp (sort tmp >))))))

(define (solve n)
  (let ((n (/ n 100)))
    (let loop ((i 100) (acc 0))
      (let ((tmp (if (bouncy? i)
                     (+ acc 1)
                     acc)))
        (if (= (/ tmp i) n)
            i
            (loop (+ i 1) tmp))))))

(let ((_ (solve 99)))
  (print _) (assert (= _ 1587000)))
