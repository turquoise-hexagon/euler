(import
  (euler-syntax))

(define (solve limit)
  (define-memoized (loop flag count a b)
    (if (= count limit)
      1
      (let subloop ((c 0) (acc 0))
        (if (and flag (= c 0))
          (subloop (+ c 1) acc)
          (if (> (+ a b c) 9)
            acc
            (subloop (+ c 1) (+ acc (loop #f (+ count 1) b c))))))))
  (loop #t 0 0 0))

(let ((_ (solve 20)))
  (print _) (assert (= _ 378158756814587)))
