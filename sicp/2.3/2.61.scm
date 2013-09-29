(define (adjoin-set x set)
  (cond ((null? set) (cons x set))
		((= x (car set)) set)
		((< x (car set)) (cons x set))
		(else (cons (car set) (adjoin-set x (cdr set))))))

(adjoin-set 3 (list 1 2 3 4 5))
(adjoin-set 3 (list 1 2 4 5))
