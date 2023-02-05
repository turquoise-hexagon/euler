(import
  (euler))

(define (delete-once l n)
  (if (= (car l) n)
    (cdr l)
    (cons (car l) (delete-once (cdr l) n))))

(define (solve n l)
  (foldl + 0
    (map
      (lambda (i)
        (modular-inverse n i))
      (foldl delete-once (primes l) (factorize n)))))

(let ((_ (solve 10 #e1e7)))
  (print _) (assert (= _ 1601912348822)))
