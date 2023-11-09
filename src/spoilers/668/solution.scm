(import
  (chicken fixnum)
  (euler))

(define (solve n)
  (let loop ((i 1) (acc 0))
    (if (fx> (fx* i i) n)
      (fx- n (foldl fx+ acc (primes i)))
      (let ((_ (fx+ i 1)))
        (loop _ (fx+ acc (fx* i (fx- (prime-pi (fx/ n i))
                                     (prime-pi (fx/ n _))))))))))

(let ((_ (solve #e1e10)))
  (print _) (assert (= _ 2811077773)))
