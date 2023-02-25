(import
  (chicken sort)
  (euler)
  (srfi 1)
  (srfi 69))

(define (candidates nb-digits)
  (let ((l (expt 10 (- nb-digits 1)))
        (h (- (expt 10 nb-digits) 1)))
    (drop-while
      (lambda (i)
        (< i l))
      (primes h))))

(define (identifier n)
  (list->string (sort (string->list (number->string n)) char<?)))

(define (groups nb-digits nb-numbers)
  (let ((acc (make-hash-table)))
    (for-each
      (lambda (i)
        (hash-table-update!/default acc (identifier i)
          (lambda (_) (cons i _)) '()))
      (candidates nb-digits))
    (delete '(1487 4817 8147)
      (append-map
        (lambda (lst)
          (combinations (reverse lst) nb-numbers))
        (hash-table-values acc)))))

(define (sequence? group)
  (apply
    (lambda (a b c)
      (= (- c b)
         (- b a)))
    group))

(define (convert group)
  (string->number (apply string-append (map number->string group))))

(define (solve nb-numbers nb-digits)
  (convert (find sequence? (groups nb-digits nb-numbers))))

(let ((_ (solve 3 4)))
  (print _) (assert (= _ 296962999629)))
