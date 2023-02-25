(import
  (chicken fixnum)
  (chicken sort)
  (srfi 1)
  (srfi 69))

(define-constant limit #e1e9)

(define (square n)
  (fx* n n))

(define (cube n)
  (fx* n (fx* n n)))

(define (generate limit proc)
  (let loop ((i 1) (acc '()))
    (let ((_ (proc i)))
      (if (fx> _ limit)
        acc
        (loop (fx+ i 1) (cons _ acc))))))

(define (palindrome? n)
  (let loop ((i n) (acc 0))
    (if (fx= i 0)
      (fx= n acc)
      (loop (fx/ i 10) (fx+ (fx* acc 10) (fxmod i 10))))))

(define (compute limit)
  (let ((acc (make-hash-table))
        (a (generate limit square))
        (b (generate limit cube)))
    (for-each
      (lambda (a)
        (for-each
          (lambda (b)
            (let ((_ (fx+ a b)))
              (when (palindrome? _)
                (hash-table-update!/default acc _
                  (lambda (_)
                    (fx+ _ 1))
                  0))))
          b))
      a)
    acc))

(define (solve nb-numbers nb-ways)
  (let ((acc (compute limit)))
    (foldl fx+ 0
      (take
        (sort
          (filter
            (lambda (i)
              (fx= (hash-table-ref acc i) nb-ways))
            (hash-table-keys acc))
          fx<)
        nb-numbers))))

(let ((_ (solve 5 4)))
  (print _) (assert (= _ 1004195061)))
