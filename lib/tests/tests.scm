#!/usr/bin/csi -s

(import
  (chicken sort)
  (srfi 1)
  (srfi 69)
  (srfi 133)
  (test))

(include-relative "../euler-impl.scm")

(test-group "euler"
  (test-group "range"
    (test '()                                 (range 10 10))
    (test '(10 11 12 13 14 15 16 17 18 19 20) (range 10 20))
    (test '(20 19 18 17 16 15 14 13 12 11 10) (range 20 10))
    (test '(10 12 14 16 18 20)                (range 10 20 2)))

  (test-group "factorial"
    (test '(1 1 2 6 24 120 720 5040 40320 362880) (map factorial (iota 10))))

  (let* ((lst '((1 2 3) (4 5 6))) (array (list->array lst)))
    (test-group "array?"
      (test #t (array? array)))

    (test-group "array-dimensions"
      (test '(2 3) (array-dimensions array)))

    (test-group "array-indexes"
      (test '((0 0) (0 1) (0 2) (1 0) (1 1) (1 2)) (array-indexes array)))

    (test-group "array->list"
      (test lst (array->list array)))

    (test-group "list->array"
      (test array (list->array lst)))

    (test-group "array-ref"
      (test 1 (array-ref array '(0 0)))
      (test 2 (array-ref array '(0 1)))
      (test 3 (array-ref array '(0 2))))

    (test-group "array-set!"
      (array-set! array '(0 0) "hello")
      (array-set! array '(0 1) "world")
      (test "hello" (array-ref array '(0 0)))
      (test "world" (array-ref array '(0 1))))

    (test-group "array-copy"
      (test array (array-copy array)))

    (test-group "array-exists?"
      (test #t (array-exists? array '(0 0)))
      (test #f (array-exists? array '(5 5)))))

  (test-group "expt-mod"
    (test 4   (expt-mod 2 50 13))
    (test 445 (expt-mod 4 13 497)))

  (test-group "discrete-log"
    (test 1665442  (discrete-log 7 11239946 20201227))
    (test 18474687 (discrete-log 7 10464955 20201227)))

  (test-group "divisors"
    (test '(1 2 3 4 5 6 10 12 15 20 30 60) (divisors 60))
    (test '(1 2 4 5 10 10 20 25 50 100)    (divisors 100)))

  (test-group "product"
    (test '((1 2 3 4 5 6))                                                   (apply product (chop '(1 2 3 4 5 6) 1)))
    (test '((1 3 5) (1 3 6) (1 4 5) (1 4 6) (2 3 5) (2 3 6) (2 4 5) (2 4 6)) (apply product (chop '(1 2 3 4 5 6) 2)))
    (test '((1 4) (1 5) (1 6) (2 4) (2 5) (2 6) (3 4) (3 5) (3 6))           (apply product (chop '(1 2 3 4 5 6) 3))))

  (test-group "combinations"
    (test '((1) (2))                                                         (combinations '(1 2) 1))
    (test '((1 1) (2 1) (1 2) (2 2))                                         (combinations '(1 2) 2))
    (test '((1 1 1) (2 1 1) (1 2 1) (2 2 1) (1 1 2) (2 1 2) (1 2 2) (2 2 2)) (combinations '(1 2) 3)))

  (test-group "powerset"
    (test '((1) (2) (3) (4))                     (powerset '(1 2 3 4) 1))
    (test '((1 2) (1 3) (1 4) (2 3) (2 4) (3 4)) (powerset '(1 2 3 4) 2))
    (test '((1 2 3) (1 2 4) (1 3 4) (2 3 4))     (powerset '(1 2 3 4) 3)))

  (test-group "permutations"
    (test '((1))                                             (permutations '(1)))
    (test '((1 2) (2 1))                                     (permutations '(1 2)))
    (test '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 2 1) (3 1 2)) (permutations '(1 2 3))))

  (test-group "number->list"
    (test '(1 2 3 4) (number->list 1234))
    (test '(1 1 1 1) (number->list 15 2)))

  (test-group "list->number"
    (test 1234 (list->number '(1 2 3 4)))
    (test 15   (list->number '(1 1 1 1) 2)))

  (test-group "digitsum"
    (test '(25 25 23 30 32) (map digitsum '(332584 666223 470606 674418 355658))))

  (test-group "palindrome?"
    (test #f (palindrome? 1234))
    (test #t (palindrome? 1221))
    (test #f (palindrome? 14 2))
    (test #t (palindrome? 15 2)))

  (test-group "prime?"

    (test '(595123 1726489 1914503) (filter prime? '(1201906 595123 1203932 174395 405979 75097 144853 975347 1101943 1054895 1846013 1726489 452776 31845 1527170 965363 1914503 838641 1493418 547829))))

  (test-group "factorize"
    (test '(997123)                (factorize 997123))
    (test '(13 5 11 7 3 3 2 2 2 2) (factorize 720720))
    (test '(6857 1471 839 71)      (factorize 600851475143)))

  (test-group "primes"
    (test 1060 (foldl + 0 (primes 100)))))

(test-exit)
