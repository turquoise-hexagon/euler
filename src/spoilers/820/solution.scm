(import
  (chicken fixnum)
  (euler))

(define (modular-expt b e m)
  (let loop ((b b) (e e) (acc 1))
    (if (fx= e 0)
      acc
      (loop (fxmod (fx* b b) m) (fx/ e 2)
        (if (fxodd? e)
          (fxmod (fx* b acc) m)
          acc)))))

(define (f num den nth)
  (fx/ (fx* 10 (fxmod (fx* num (modular-expt 10 (fx- nth 1) den)) den)) den))

(define (solve limit)
  (do ((i 1 (fx+ i 1))
       (acc 0 (fx+ acc (f 1 i limit))))
    ((fx> i limit) acc)))

(let ((_ (solve #e1e7)))
  (print _) (assert (= _ 44967734)))
