(module euler
   (combinations
    digitsum
    discrete-log
    divisors
    expt-mod
    factorial
    factorize
    number->list
    palindrome?
    permutations
    powerset
    prime?
    primes
    product)
  (import scheme
          (chicken base)
          (chicken sort)
          (chicken string)
          (srfi 69))

  (include "euler-impl.scm"))
