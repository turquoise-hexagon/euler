(import
  (chicken fixnum)
  (euler))

(define (compare? a b)
  (fx< (car a)
       (car b)))

(define (solve limit)
  (let ((acc (make-vector (fx+ limit 1) most-positive-fixnum)))
    (vector-set! acc 0 0)
    (vector-set! acc 1 0)
    (do ((queue (priority-queue-insert (priority-queue compare?) (list 0 '(1)))
                (apply
                  (lambda (cost path)
                    (let ((cost (fx+ cost 1)))
                      (foldl
                        (lambda (queue pair)
                          (let ((next (foldl fx+ 0 pair)))
                            (cond ((fx> next limit) queue)
                                  ((fx> cost (vector-ref acc next)) queue)
                                  (else
                                    (vector-set! acc next cost)
                                    (priority-queue-insert queue (list cost (cons next path)))))))
                        (priority-queue-rest queue) (power path 2))))
                  (priority-queue-first queue))))
      ((priority-queue-empty? queue)
       (foldl fx+ 0 (vector->list acc))))))

(let ((_ (solve 200)))
  (print _) (assert (= _ 1582)))
