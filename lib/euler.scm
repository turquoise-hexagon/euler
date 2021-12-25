(module euler
  (array->list
   array-copy
   array-dimensions
   array-exists?
   array-indexes
   array-ref
   array-set!
   array?
   combinations
   digitsum
   discrete-log
   divisors
   expt-mod
   factorial
   factorize
   list->array
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
          (srfi 1)
          (srfi 69)
          (srfi 133))

  (include "euler-impl.scm"))
