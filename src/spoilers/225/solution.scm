(import
  (chicken string)
  (srfi 69))

(define (id . arg)
  (string-intersperse (map number->string arg)))

(define (valid? n)
  (let ((acc (make-hash-table)))
    (let loop ((a 1) (b 1) (c 1))
      (let ((id (id a b c)))
        (if (= c 0)
          #f
          (if (hash-table-exists? acc id)
            #t
            (begin
              (hash-table-set! acc id #t)
              (loop b c (modulo (+ a b c) n)))))))))

(define (solve n)
  (let loop ((i 1) (cnt 0))
    (let ((cnt (if (valid? i)
                 (+ cnt 1)
                 cnt)))
      (if (= cnt n)
        i
        (loop (+ i 2) cnt)))))

(let ((_ (solve 124)))
  (print _) (assert (= _ 2009)))
