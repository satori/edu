(define (make-vect x y)
  (cons x y))

(define (make-segment start end)
  (cons start end))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(start-segment (make-segment (make-vect 1 1) (make-vect 2 2)))
(end-segment (make-segment (make-vect 1 1) (make-vect 2 2)))
