(import euler)

(define (main n)
  (let helper ((lst (sieve n)) (acc 0) (num 0))
    (if (null? lst)
        acc
        (let helper-2 ((lst-2 lst) (acc-2 0) (num-2 0))
          (if (or (null? lst-2)
                  (> (+ acc-2 (car lst-2)) n))
              (if (and (> num-2 num)
                       (member acc-2 lst))
                  (helper (cdr lst) acc-2 num-2)
                  (helper (cdr lst) acc num))
              (helper-2 (cdr lst-2) (+ acc-2 (car lst-2)) (add1 num-2)))))))

(display (main 1000000))
(newline)
