(import
  (chicken io)
  (chicken string))

(define (import-input)
  (list->vector
    (map
      (lambda (str)
        (list->vector
          (map
            (lambda (i)
              (let ((_ (string->number i))) (if _ _ +inf.0)))
            (string-split str ","))))
      (read-lines))))

(define (find vec i)
  (let loop ((i i))
    (let ((_ (vector-ref vec i)))
      (if (= _ i)
        i
        (loop _)))))

(define (union! vec a b)
  (vector-set! vec
    (find vec a)
    (find vec b)))

(define (helper matrix nb mem)
  (let loop ((i 0) (m +inf.0) (a -1) (b -1))
    (if (= i nb)
      (values m a b)
      (let subloop ((j 0) (m m) (a a) (b b))
        (if (= j nb)
          (loop (+ i 1) m a b)
          (let ((_ (vector-ref (vector-ref matrix i) j)))
            (if (and (not (= (find mem i)
                             (find mem j)))
                     (< _ m))
              (subloop (+ j 1) _ i j)
              (subloop (+ j 1) m a b))))))))

(define (kruskal matrix)
  (let* ((nb (vector-length matrix)) (mem (make-vector nb)))
    (do ((i 0 (+ i 1))) ((= i nb))
      (vector-set! mem i i))
    (let loop ((i 0) (acc 0))
      (if (= i (- nb 1))
        acc
        (let-values (((m a b) (helper matrix nb mem)))
          (union! mem a b)
          (loop (+ i 1) (+ acc m)))))))

(define (value matrix)
  (foldl
    (lambda (acc i)
      (if (= i +inf.0) acc (+ acc (/ i 2))))
    0 (join (map vector->list (vector->list matrix)))))

(define (solve input)
  (- (value input) (kruskal input)))

(let ((_ (solve (import-input))))
  (print _) (assert (= _ 259679)))
