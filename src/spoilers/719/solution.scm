(import
  (chicken fixnum))

(define (valid? n)
  (let main ((r n) (s (fx* n n)))
    (cond
      ((fx> r s) #f)
      ((fx= r s) #t)
      (else
       (let loop ((i 10))
         (let ((q (fx/ s i)) (m (fxmod s i)))
           (if (fx> s i)
             (if (and (fx> r m) (main (fx- r m) q))
               #t
               (loop (fx* i 10)))
             #f)))))))

(define (solve n)
  (let loop ((i 2) (acc 0))
    (if (fx> (fx* i i) n)
      acc
      (loop (fx+ i 1)
        (if (valid? i)
          (fx+ acc (fx* i i))
          acc)))))

(let ((_ (solve #e1e12)))
  (print _) (assert (= _ 128088830547982)))
