(import (chicken io)
        (matchable)
        (srfi 69)
        (srfi 1))

(define (import-input)
  (map string->list (read-lines)))

(define (graph input)
  (define (graph/h hash key value)
    (let ((query (hash-table-ref/default hash key '())))
      (unless (member value query) (hash-table-set! hash key (cons value query)))))
  (let ((hash (make-hash-table)))
    (for-each
      (match-lambda
        ((a b c)
         (graph/h hash a b)
         (graph/h hash b c)))
      input)
    hash))

(define (uniq hash)
  (hash-table-fold hash
    (lambda (key val acc)
      (if (= (length val) 1)
          (cons key val)
          acc))
    '()))

(define (path hash)
  (let ((keys (hash-table-keys hash)))
    (let path/h ((acc '()) (last 0))
      (if (= (length acc) (length keys))
          (cons last acc)
          (match (uniq hash)
            ((key val)
             (for-each
               (lambda (i)
                 (hash-table-set! hash i (delete val (hash-table-ref hash i))))
               keys)
             (path/h (cons val acc) key)))))))

(define (solve input)
  (list->string (path (graph input))))

(print (solve (import-input)))
