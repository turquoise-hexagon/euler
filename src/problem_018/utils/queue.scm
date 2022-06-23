(define-syntax priority-queue-rank (syntax-rules () ((_ p) (vector-ref p 0))))
(define-syntax priority-queue-item (syntax-rules () ((_ p) (vector-ref p 1))))
(define-syntax priority-queue-lkid (syntax-rules () ((_ p) (vector-ref p 2))))
(define-syntax priority-queue-rkid (syntax-rules () ((_ p) (vector-ref p 3))))

(define priority-queue-empty
  (vector 0 'priority-queue-empty 'priority-queue-empty 'priority-queue-empty))

(define (priority-queue-empty? p)
  (eqv? p priority-queue-empty))

(define (priority-queue-swap item lkid rkid)
  (let ((rank/lkid (priority-queue-rank lkid))
        (rank/rkid (priority-queue-rank rkid)))
    (if (< rank/rkid rank/lkid)
      (vector (+ rank/rkid 1) item lkid rkid)
      (vector (+ rank/lkid 1) item rkid lkid))))

(define (priority-queue-merge comp? p/1 p/2)
  (cond
    ((priority-queue-empty? p/1) p/2)
    ((priority-queue-empty? p/2) p/1)
    (else
      (let ((item/1 (priority-queue-item p/1))
            (item/2 (priority-queue-item p/2)))
        (if (comp? item/2 item/1)
          (priority-queue-swap item/2 (priority-queue-lkid p/2)
            (priority-queue-merge comp? p/1 (priority-queue-rkid p/2)))
          (priority-queue-swap item/1 (priority-queue-lkid p/1)
            (priority-queue-merge comp? (priority-queue-rkid p/1) p/2)))))))

(define (priority-queue-insert comp? x p)
  (priority-queue-merge comp? (vector 1 x priority-queue-empty priority-queue-empty) p))

(define (priority-queue-first p)
  (if (priority-queue-empty? p)
      (error 'priority-queue-first "empty priority queue")
      (priority-queue-item p)))

(define (priority-queue-rest comp? p)
  (if (priority-queue-empty? p)
      (error 'priority-queue-rest "empty priority queue")
      (priority-queue-merge comp? (priority-queue-lkid p) (priority-queue-rkid p))))
