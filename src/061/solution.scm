(import
  (srfi 1))

(define-constant lim/l 1000)
(define-constant lim/h 9999)

(define (proc/3 n) (quotient (* n (+ (* 1 n) 1)) 2))
(define (proc/4 n) (* n (+ (* 1 n) 0)))
(define (proc/5 n) (quotient (* n (- (* 3 n) 1)) 2))
(define (proc/6 n) (* n (- (* 2 n) 1)))
(define (proc/7 n) (quotient (* n (- (* 5 n) 3)) 2))
(define (proc/8 n) (* n (- (* 3 n) 2)))

(define (generate proc)
  (let loop ((i 1) (acc '()))
    (let ((tmp (proc i)))
      (if (> tmp lim/h)
        acc
        (loop (+ i 1)
          (if (> tmp lim/l)
            (cons tmp acc)
            acc))))))

(define (cyclic? a b)
  (= (modulo a 100) (quotient b 100)))

(define (helper lst acc proc)
  (if (null? lst)
    (when (cyclic? (last acc) (car acc))
      (proc (apply + acc)))
    (for-each
      (lambda (sub)
        (let ((next (delete sub lst)))
          (for-each
            (lambda (i)
              (when (cyclic? i (car acc))
                (helper next (cons i acc) proc)))
            sub)))
      lst)))

(define (solve)
  (let ((lst (list (generate proc/4)
                   (generate proc/5)
                   (generate proc/6)
                   (generate proc/7)
                   (generate proc/8))))
    (call/cc
      (lambda (proc)
        (for-each
          (lambda (i)
            (helper lst (list i) proc))
          (generate proc/3))))))

(let ((_ (solve)))
  (print _) (assert (= _ 28684)))
