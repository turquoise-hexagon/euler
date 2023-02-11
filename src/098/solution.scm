(import
  (chicken io)
  (chicken string)
  (euler)
  (srfi 1))

(define digits (range 1 9))

(define (import-input)
  (map
    (lambda (s)
      (map char->integer (string->list s)))
    (string-split (read-line) "\",")))

(define-syntax helper!
  (syntax-rules ()
    ((_ acc l i)
     (for-each
       (lambda (c)
         (vector-set! acc c (+ (vector-ref acc c) i)))
       l))))

(define (anagram? a b)
  (let ((acc (make-vector 256 0)))
    (helper! acc a +1)
    (helper! acc b -1)
    (let loop ((l (append a b)))
      (if (null? l)
        #t
        (if (= (vector-ref acc (car l)) 0)
          (loop (cdr l))
          #f)))))

(define (make-mappings)
  (let ((cache (make-vector 26 #f)))
    (define (mappings c)
      (let* ((l (length c)) (m (vector-ref cache l)))
        (if m m
          (let ((m (join (map permutations (combinations digits l)))))
            (vector-set! cache l m)
            m))))
    mappings))

(define (dictionary c m)
  (let ((acc (make-vector 256 0)))
    (for-each
      (lambda (c d)
        (vector-set! acc c d))
      c m)
    acc))

(define (translate d l)
  (list->number
    (map
      (lambda (c)
        (vector-ref d c))
      l)))

(define (square? n)
  (let loop ((i n))
    (let ((_ (quotient (+ (quotient n i) i) 2)))
      (if (< _ i)
        (loop _)
        (= (* i i) n)))))

(define (make-squares)
  (let ((mappings (make-mappings)))
    (define (squares a b)
      (let ((c (delete-duplicates a)))
        (join
          (filter-map
            (lambda (m)
              (let ((d (dictionary c m)))
                (let ((a (translate d a))
                      (b (translate d b)))
                  (if (and (square? a)
                           (square? b))
                    (list a b)
                    #f))))
            (mappings c)))))
    squares))

(define (make-square-anagram?)
  (let ((squares (make-squares)))
    (define (square-anagram? a b)
      (if (and (= (length a)
                  (length b))
               (anagram? a b))
        (let ((_ (squares a b)))
          (if (null? _)
            #f
            _))
        #f))
    square-anagram?))

(define (solve input)
  (let ((square-anagram? (make-square-anagram?)))
    (apply max
      (flatten
        (filter-map
          (lambda (l)
            (apply square-anagram? l))
          (combinations input 2))))))

(print (solve (import-input)))
