(define (make-interval a b)
  (cons a b))

(define (lower-bound i)
  (car i))

(define (upper-bound i)
  (cdr i))

(lower-bound (make-interval 6.12 7.48))
(upper-bound (make-interval 6.12 7.48))
