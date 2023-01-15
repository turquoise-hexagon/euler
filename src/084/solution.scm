(import
  (chicken random)
  (chicken sort)
  (euler)
  (srfi 69)
  (srfi 152)
  (srfi 209)
  (only (srfi 1) take))

(define board 
  (make-enum-type
    '(go   a1 cc1 a2  t1 r1 b1  ch1 b2 b3
      jail c1 u1  c2  c3 r2 d1  cc2 d2 d3
      fp   e1 ch2 e2  e3 r3 f1  f2  u2 f3
      g2j  g1 g2  cc3 g3 r4 ch3 h1  t2 h2)))

(define community-chest
  '(advance-to-go
    go-to-jail
    other
    other
    other
    other
    other
    other
    other
    other
    other
    other
    other
    other
    other
    other))

(define chance
  '(advance-to-go
    go-to-jail
    go-to-c1
    go-to-e3
    go-to-h2
    go-to-r1
    go-to-next-r
    go-to-next-r
    go-to-next-u
    go-back-3-squares
    other
    other
    other
    other
    other
    other))

(define-syntax swap!
  (syntax-rules ()
    ((_ a b)
     (let ((_ a))
       (set! a b)
       (set! b _)))))

(define (shuffle! lst)
  (let loop ((i (- (length lst) 1)))
    (if (= i 1)
      lst
      (let ((_ (pseudo-random-integer (+ i 1))))
        (swap!
          (list-ref lst _)
          (list-ref lst i))
        (loop (- i 1))))))

(define (make-dice nb-dice nb-faces)
  (let ((_ (range 1 nb-dice)))
    (lambda ()
      (let ((_ (map
                 (lambda (_)
                   (+ (pseudo-random-integer nb-faces) 1))
                 _)))
        (values (apply + _) (apply = _))))))

(define-syntax take-card!
  (syntax-rules ()
    ((_ deck)
     (let ((_ (car deck)))
       (set! deck (append (cdr deck) (list _)))
       _))))

(define (monopoly nb-rolls nb-dice nb-faces)
  ;; init variables
  (shuffle! community-chest) (shuffle! chance)
  (let ((acc (make-hash-table)) (dice (make-dice nb-dice nb-faces)) (len (enum-type-size board)))
    (let loop ((rolls 0) (position 0) (consecutive-duplicates 0))
      (if (> rolls nb-rolls)
        (hash-table->alist acc)
        (begin
          ;; increment occurrences of position
          (hash-table-update!/default acc position (lambda (_) (+ _ 1)) 0)

          (let-values (((roll duplicate?) (dice)))
            
            ;; handle consecutive duplicates
            (let ((consecutive-duplicates
                    (if duplicate?
                      (+ consecutive-duplicates 1)
                      0)))

              (if (= consecutive-duplicates 3)
                (loop (+ rolls 1) (enum-name->ordinal board 'jail) 0)

                (let* ((position (modulo (+ position roll len) len)) (_ (enum-ordinal->name board position)))
                    (case _
                      ;; handle complex cases
                      ((cc1 cc2 cc3 ch1 ch2 ch3)
                       (loop (+ rolls 1)
                         (case
                           ;; get a card from the relevant deck
                           (case _
                             ((cc1 cc2 cc3)
                              (take-card! community-chest))
                             ((ch1 ch2 ch3)
                              (take-card! chance)))

                           ;; handle simple cases
                           ((advance-to-go)
                            (enum-name->ordinal board 'go))
                           ((go-to-jail)
                            (enum-name->ordinal board 'jail))
                           ((go-to-c1)
                            (enum-name->ordinal board 'c1))
                           ((go-to-e3)
                            (enum-name->ordinal board 'e3))
                           ((go-to-h2)
                            (enum-name->ordinal board 'h2))
                           ((go-to-r1)
                            (enum-name->ordinal board 'r1))

                           ;; handle complex cases
                           ((go-to-next-r)
                            (let loop ((_ position))
                              (case (enum-ordinal->name board _)
                                ((r1 r2 r3 r4) _)
                                (else (loop (modulo (+ _ 1 len) len))))))

                           ((go-to-next-u)
                            (let loop ((_ position))
                              (case (enum-ordinal->name board _)
                                ((u1 u2) _)
                                (else (loop (modulo (+ _ 1 len) len))))))

                           ((go-back-3-squares)
                            (let ((_ (modulo (+ position -3 len) len)))
                              (if (= _ (enum-name->ordinal board 'g2j))
                                (enum-ordinal->name board 'jail)
                                _)))

                           (else position))
                         consecutive-duplicates))

                      ;; handle simple cases
                      ((g2j)
                       (loop (+ rolls 1) (enum-name->ordinal board 'jail) consecutive-duplicates))
                      (else
                       (loop (+ rolls 1) position consecutive-duplicates))))))))))))

(define (solve nb-dice nb-faces)
  (let ((_ (sort (monopoly 1000000 nb-dice nb-faces)
             (lambda (a b)
               (> (cdr a)
                  (cdr b))))))
    (apply string-append
      (map
        (lambda (_)
          (string-pad (number->string (car _)) 2 #\0))
        (take _ 3)))))

(let ((_ (solve 2 4)))
  (print _) (assert (string=? _ "101524")))
