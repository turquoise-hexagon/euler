(module euler
  (combinations
   digitsum
   discrete-log
   divisors
   expt-mod
   factorial
   factorize
   list->number
   number->list
   palindrome?
   permutations
   powerset
   prime?
   primes
   product
   range)
  (import scheme
          (chicken base)
          (chicken sort)
          (chicken string)
          (srfi 69))

  (include "euler-impl.scm"))
