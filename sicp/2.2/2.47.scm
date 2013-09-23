(define (make-vect x y)
  (cons x y))

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(origin-frame (make-frame (make-vect 1 1) (make-vect 2 2) (make-vect 3 3)))
(edge1-frame (make-frame (make-vect 1 1) (make-vect 2 2) (make-vect 3 3)))
(edge2-frame (make-frame (make-vect 1 1) (make-vect 2 2) (make-vect 3 3)))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (edge2-frame frame)
  (cddr frame))

(origin-frame (make-frame (make-vect 1 1) (make-vect 2 2) (make-vect 3 3)))
(edge1-frame (make-frame (make-vect 1 1) (make-vect 2 2) (make-vect 3 3)))
(edge2-frame (make-frame (make-vect 1 1) (make-vect 2 2) (make-vect 3 3)))
