(import
  (euler)
  (srfi 1))

(define (rotations n)
  (let* ((tmp (number->list n)) (len (length tmp)))
    (let loop ((i 0) (lst (apply circular-list tmp)) (acc '()))
      (if (= i len)
        (map list->number acc)
        (loop (+ i 1) (cdr lst) (cons (take lst len) acc))))))

(define (valid? n)
  (every prime? (rotations n)))

(define (solve n)
  (count valid? (range 1 n)))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 55)))
