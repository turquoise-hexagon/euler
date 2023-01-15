(define (solve lim n d)
  (let loop
    ((ln 0) (ld 1)  ;; low
     (hn 1) (hd 1)  ;; high
     (mn 0) (md 0)) ;; middle
    (if (> (+ ld hd) lim)
      (list mn md)
      (let ((mn (+ ln hn))
            (md (+ ld hd)))
        (if (or (= (/ mn md) (/ n d))
                (> (* mn d) (* md n)))
          (loop ln ld mn md mn md)
          (loop mn md hn hd mn md))))))

(let ((_ (car (solve #e1e6 3 7))))
  (print _) (assert (= _ 428570)))
