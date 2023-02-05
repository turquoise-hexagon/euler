(import
  (euler))

(define (solve k n)
  (let loop ((i 1) (cnt 0) (acc 0))
    (if (= cnt n)
      acc
      (if (prime? i)
        (if (= (modular-expt 10 k (* i 9)) 1)
          (loop (+ i 1) (+ cnt 1) (+ acc i))
          (loop (+ i 1) cnt acc))
        (loop (+ i 1) cnt acc)))))

(let ((_ (solve #e1e9 40)))
  (print _) (assert (= _ 843296)))
