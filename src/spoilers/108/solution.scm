(import
  (chicken sort)
  (euler)
  (srfi 1)
  (srfi 69))

(include-relative "input.scm")

(define-constant limit 50)

(define (nb-solutions n)
  (quotient
    (foldl
      (lambda (acc i)
        (* acc (+ (* (car i) 2) 1)))
      1 (run-length (factors n)))
    2))

(define (next primes current)
  (map
    (lambda (i)
      (* current i))
    primes))

(define (compute table target-nb-solutions)
  (hash-table-ref table
    (find
      (lambda (i)
        (> i target-nb-solutions))
      (sort (hash-table-keys table) <))))

(define (solve target-nb-solutions)
  (let ((primes (primes limit)) (acc (make-hash-table)))
    (do ((queue
           (priority-queue-insert (priority-queue <) 1)
           (foldl
             (lambda (queue i)
               (let ((nb-solutions (nb-solutions i)))
                 (if (> nb-solutions (* 2 target-nb-solutions))
                   queue
                   (if (> (hash-table-ref/default acc nb-solutions +inf.0) i)
                     (begin
                       (hash-table-set! acc nb-solutions i)
                       (priority-queue-insert queue i))
                     queue))))
             (priority-queue-rest queue) (next primes (priority-queue-first queue)))))
      ((priority-queue-empty? queue) (compute acc target-nb-solutions)))))

(print (solve input))
