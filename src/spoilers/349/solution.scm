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
(define-constant center '(50 50))

(define (array-init)
  (list->array (make-list h (make-list w #f))))

(define (iterate-array! array dir coord)
  (let* ((len (length dirs)) (val (array-ref array coord)) (dir (modulo (+ dir (if val +1 -1) len) len)))
    (array-set! array coord (not val))
    (values dir
      (map
        (lambda (coord offset dim)
          (modulo (+ coord offset dim) dim))
        coord (list-ref dirs dir) (array-dimensions array)))))

(define (array-count array)
  (count
    (lambda (coord)
      (array-ref array coord))
    (array-indexes array)))

(define (solve n)
  (let ((array (array-init)))
    (let loop ((t 0) (dir 0) (coord center) (prev 0) (diff 0) (cnt 0))
      (if (= cnt 10)
        ;; cycle found, jump ahead
        (let ((add (* (quotient (- n t) cycle) diff)))
          (let loop ((t (+ (* (quotient (- n t) cycle) cycle) t)) (dir dir) (coord coord))
            (if (= t n)
              ;; compute result
              (+ (array-count array) add)
              (let-values (((dir coord) (iterate-array! array dir coord)))
                (loop (+ t 1) dir coord)))))
        ;; cycle not found, search further
        (let subloop ((i 0) (dir dir) (coord coord))
          (if (= i cycle)
            (let* ((next-prev (array-count array)) (next-diff (- next-prev prev)))
              (loop (+ t cycle) dir coord next-prev next-diff
                (if (= diff next-diff)
                  (+ cnt 1)
                  0)))
            (let-values (((dir coord) (iterate-array! array dir coord)))
              (subloop (+ i 1) dir coord))))))))

(let ((_ (solve #e1e18)))
  (print _) (assert (= _ 115384615384614952)))
