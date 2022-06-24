(import
  (chicken io)
  (chicken string)
  (euler)
  (srfi 1)
  (srfi 69))

(define DIGITS (range 1 9))

(define (import-input)
  (map
    (lambda (lst)
      (map char->integer lst))
    (map string->list (string-split (read-line) "\", "))))

(define-syntax increment!
  (syntax-rules ()
    ((_ array index proc)
     (vector-set! array index
       (proc (vector-ref array index))))))

(define (anagram? a b)
  ;; attempt at fast-ish anagram testing
  (let ((acc (make-vector 256 0)))
    (for-each (lambda (i) (increment! acc i (lambda (_) (+ _ 1)))) a)
    (for-each (lambda (i) (increment! acc i (lambda (_) (- _ 1)))) b)
    (call/cc
      (lambda (_)
        (for-each (lambda (i) (unless (= (vector-ref acc i) 0) (_ #f))) a)
        (for-each (lambda (i) (unless (= (vector-ref acc i) 0) (_ #f))) b)
        (_ #t)))))

(define (square? n)
  (integer? (sqrt n)))

(define (square-anagram? a b)
  (let ((chars (delete-duplicates a =)))
    (filter-map
      (lambda (digits)
        (let ((acc (make-hash-table)))
          (for-each
            (lambda (char digit)
              (hash-table-set! acc char digit))
            chars digits)
          ;; get out candidate numbers out of this
          (let ((a (list->number (map (lambda (i) (hash-table-ref acc i)) a)))
                (b (list->number (map (lambda (i) (hash-table-ref acc i)) b))))
            (if (and (square? a)
                     (square? b))
              (list a b)
              #f))))
      (join (map permutations (powerset DIGITS (length chars)))))))

(define (solve input)
  (apply max
    (flatten
      (filter-map (lambda (i) (apply square-anagram? i))
        (filter (lambda (i) (apply anagram? i))
          (powerset input 2))))))

(let ((input (import-input)))
  (print (solve input)))
