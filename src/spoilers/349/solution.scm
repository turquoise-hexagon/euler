(import
  (euler)
  (srfi 1))

(define-constant dirs
  '((-1  0)
    ( 0  1)
    ( 1  0)
    ( 0 -1)))

(define-constant cycle 104)

(define-constant h 100)
(define-constant w 100)

(define (array-init)
  (list->array (make-list h (make-list w #f))))

(define (iterate-array! array dir coord)
  (let* ((len (length dirs)) (val (array-ref array coord)) (dir (modulo (+ dir (if val +1 -1) len) len)))
    (array-set! array coord (not val))
    (list
      (map
        (lambda (coord offset dim)
          (modulo (+ coord offset dim) dim))
        coord (list-ref dirs dir) (array-dimensions array))
      dir)))

(define (array-count array)
  (count
    (lambda (coord)
      (array-ref array coord))
    (array-indexes array)))

(define (solve n)
  (let ((array (array-init)))
    (let loop ((t 0) (coord '(0 0)) (dir 0) (prev 0) (diff 0) (cnt 0))
      (if (= cnt 10)
        ;; cycle found, jump ahead
        (let loop ((i (+ (* (quotient (- n t) cycle) cycle) t)) (coord coord) (dir dir))
          (if (= i n)
            ;; compute result
            (+ (array-count array) (* (quotient (- n t) cycle) diff))
            (apply loop (+ i 1) (iterate-array! array dir coord))))
        ;; cycle not found, search further
        (let subloop ((i 0) (coord coord) (dir dir))
          (if (= i cycle)
            (let* ((next-prev (array-count array)) (next-diff (- next-prev prev)))
              (loop (+ t i) coord dir next-prev next-diff
                (if (= next-diff diff)
                  (+ cnt 1)
                  0)))
            (apply subloop (+ i 1) (iterate-array! array dir coord))))))))

(let ((_ (solve #e1e18)))
  (print _) (assert (= _ 115384615384614952)))
