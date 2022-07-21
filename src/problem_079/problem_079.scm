(import
  (chicken io)
  (srfi 69)
  (srfi 1))

(define (add-connection! graph a b)
  (hash-table-update!/default graph a
    (lambda (current)
      (if (not (member b current))
        (cons b current)
        current))
    '()))

(define (graph attempts)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (attempt)
        (apply
          (lambda (a b c)
            (add-connection! acc a b)
            (add-connection! acc b c))
          attempt))
      attempts)
    acc))

(define (import-input)
  (graph (map string->list (read-lines))))

(define (single graph)
  (let loop ((keys (hash-table-keys graph)))
    (let ((_ (hash-table-ref graph (car keys))))
      (if (= (length _) 1)
        (cons (car keys) _)
        (loop (cdr keys))))))

(define (path graph)
  (let ((keys (hash-table-keys graph)))
    (let loop ((last 0) (acc '()))
      (if (= (length acc) (length keys))
        (cons last acc)
        (apply
          (lambda (key value)
            (for-each
              (lambda (i)
                (hash-table-update! graph i (lambda (_) (delete value _))))
              keys)
            (loop key (cons value acc)))
          (single graph))))))

(define (solve input)
  (list->string (path input)))

(print (solve (import-input)))
