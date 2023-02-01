(import
  (chicken fixnum))

(define-syntax test?
  (syntax-rules ()
   ((_ n compare?)
    (let loop ((c (fx/ n 10)) (p (fxmod n 10)))
      (if (fx= c 0)
        #t
        (let ((t (fxmod c 10)))
          (if (compare? p t)
            (loop (fx/ c 10) t)
            #f)))))))

(define (bouncy? n)
  (not (or (test? n <=)
           (test? n >=))))

(define (solve n)
  (let loop ((i 100) (c 0))
    (let ((t (if (bouncy? i)
                 (fx+ c 1)
                 c)))
      (if (fx= (fx/ (fx* t 100) i) n)
        i
        (loop (fx+ i 1) t)))))

(let ((_ (solve 99)))
  (print _) (assert (= _ 1587000)))
