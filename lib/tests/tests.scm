#!/usr/bin/csi -s

(import
  (chicken sort)
  (srfi 1)
  (srfi 69)
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

  (test-group "trial-division-prime?"
    (test 1060 (foldl + 0 (filter trial-division-prime? (cdr (iota 100 1))))))

  (test-group "prime?"
    (test '(1153577 1396987 1231091 1781453 1568521 1264651 1446617 1620431) (filter prime? '(1153577 1396987 1231091 1781453 1568521 1264651 1446617 1620431 1429708 1410621 1529543 1223174 1746530))))

  (test-group "factorize"
    (test '(997123)                (factorize 997123))
    (test '(13 5 11 7 3 3 2 2 2 2) (factorize 720720))
    (test '(6857 1471 839 71)      (factorize 600851475143)))

  (test-group "primes"
    (test 1060 (foldl + 0 (primes 100)))))

(test-exit)
