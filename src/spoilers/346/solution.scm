(import
  (srfi 69))

(define-syntax t
  (syntax-rules ()
    ((_ n b)
     (quotient (- (expt b n) 1) (- b 1)))))

(define (solve limit)
  (let ((acc (make-hash-table)))
    (hash-table-set! acc 1 1)
    (let loop ((n 3))
      (if (> (t n 2) limit)
        (foldl + 0 (hash-table-keys acc))
        (let subloop ((b 2))
          (let ((v (t n b)))
            (if (> v limit)
              (loop (+ n 1))
              (begin
                (hash-table-set! acc v #t)
                (subloop (+ b 1))))))))))

(let ((_ (solve #e1e12)))
  (print _) (assert (= _ 336108797689259276)))
