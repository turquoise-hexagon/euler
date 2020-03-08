(module euler
        (number->list
         list->number
         digitsum
         factorial
         reverse-number
         sieve
         palindrome?
         prime?)

        (import scheme
                (chicken base))

        (include "euler-impl.scm"))
