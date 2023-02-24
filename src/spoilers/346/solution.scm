(import
  (srfi 69))

(define-syntax f
  (syntax-rules ()
    ((_ a b)
     (quotient (- (expt b a) 1) (- b 1)))))

(define (solve n)
  (let ((acc (make-hash-table)))
    (do ((a 3 (+ a 1))) ((> (f a 2) n))
      (do ((b 2 (+ b 1))
           (v (f a 2)
              (f a b)))
        ((> v n))
        (hash-table-set! acc v #t)))
    (foldl + 1 (hash-table-keys acc))))

(let ((_ (solve #e1e12)))
  (print _) (assert (= _ 336108797689259276)))
