(import
  (srfi 69))

(define-constant inf #e1e64)

(define (helper n)
  (let ((mem (make-hash-table)))
    (hash-table-set! mem 0 0)
    (let loop ((i 1) (acc inf))
      (if (= acc inf)
        (let ((m (- n (modulo (expt 10 i) n))))
          (for-each
            (lambda (a)
              (for-each
                (lambda (b)
                  (let* ((a (+ (* 10 a) b)) (b (modulo a n)))
                    (hash-table-update!/default mem b (lambda (i) (min a i)) inf)))
                '(0 1 2)))
            (hash-table-values mem))
          (loop (+ i 1)
            (foldl
              (lambda (acc a)
                (let ((b (modulo (* a m) n)))
                  (if (hash-table-exists? mem b)
                    (let ((c (+ (* (expt 10 i) (hash-table-ref mem a)) (hash-table-ref mem b))))
                      (if (= c 0) acc
                        (min c acc)))
                    acc)))
              acc (hash-table-keys mem))))
        acc))))

(define (f n)
  (if (< n 3) n
    (helper n)))

(define (solve n)
  (let loop ((i 1) (acc 0))
    (if (> i n)
      acc
      (loop (+ i 1) (+ acc (quotient (f i) i))))))

(let ((_ (solve #e1e4)))
  (print _) (assert (= _ 1111981904675169)))
