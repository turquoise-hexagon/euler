(module euler
        (number->list
         list->number
         digitsum
         fact
         reverse-number
         sieve
         palindrome?
         prime?)

        (import scheme
                (chicken base))

        (include "euler-impl.scm"))
