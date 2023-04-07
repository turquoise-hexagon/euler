(import
  (euler))

(define (palindrome n base bool)
  (let loop ((n (if bool (quotient n base) n)) (acc n))
    (if (= n 0)
      acc
      (loop (quotient n base) (+ (* acc base) (modulo n base))))))

(define (_palindromes limit base bool)
  (let loop ((i 1) (acc '()))
    (let ((_ (palindrome i base bool)))
      (if (> _ limit)
        acc
        (loop (+ i 1) (cons _ acc))))))

(define (palindromes limit base)
  (append
    (_palindromes limit base #t)
    (_palindromes limit base #f)))

(define (solve limit)
  (foldl
    (lambda (acc i)
      (if (palindrome? i)
        (+ acc i)
        acc))
    0 (palindromes limit 2)))

(let ((_ (solve #e1e6)))
  (print _) (assert (= _ 872187)))
