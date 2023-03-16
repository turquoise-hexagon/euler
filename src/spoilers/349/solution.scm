(import
  (euler)
  (srfi 1))

(define-constant dirs
  '((-1  0)
    ( 0  1)
    ( 1  0)
    ( 0 -1)))

(define-constant cycle 104)

(define (create-array)
  (list->array (make-list 100 (make-list 100 #f))))

(define (iterate-array! array coord dir prev)
  (let* ((len (length dirs)) (val (array-ref array coord)) (dir (modulo (+ dir (if val +1 -1) len) len)))
    (array-set! array coord (not val))
    (list
      (map
        (lambda (coord offset dim)
          (modulo (+ coord offset dim) dim))
        coord (list-ref dirs dir) (array-dimensions array))
      dir
      (if (not val)
        (+ prev 1)
        (- prev 1)))))

(define (solve n)
  (let ((array (create-array)))
    (let loop ((t 0) (coord '(0 0)) (dir 0) (prev 0) (diff 0) (cnt 0))
      (if (= cnt 10)
        (let loop ((i (+ (* (quotient (- n t) cycle) cycle) t)) (coord coord) (dir dir) (prev prev))
          (if (= i n)
            (+ prev (* (quotient (- n t) cycle) diff))
            (apply loop (+ i 1) (iterate-array! array coord dir prev))))
        (let subloop ((i 0) (coord coord) (dir dir) (next-prev prev))
          (if (= i cycle)
            (let ((next-diff (- next-prev prev)))
              (loop (+ t i) coord dir next-prev next-diff
                (if (= next-diff diff)
                  (+ cnt 1)
                  0)))
            (apply subloop (+ i 1) (iterate-array! array coord dir next-prev))))))))

(let ((_ (solve #e1e18)))
  (print _) (assert (= _ 115384615384614952)))
