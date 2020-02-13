(module euler
        (number->list
         list->number
         digitsum
         fact
         sieve
         prime?)

        (import scheme
                (chicken base))

        (include "euler-impl.scm"))
