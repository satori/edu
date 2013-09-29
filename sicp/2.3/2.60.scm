(define (element-of-set? x set)
  (cond ((null? set) #f)
		((equal? x (car set)) #t)
		(else (element-of-set? x (cdr set)))))

(define adjoin-set cons)
(define union-set append)

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
		((element-of-set? (car set1) set2)
		 (cons (car set1)
			   (intersection-set (cdr set1) set2)))
		(else (intersection-set (cdr set1) set2))))

(union-set (list 1 2 3 4 5) (list 4 5 6 7 8 9))
(intersection-set (list 1 2 3 4 5) (list 1 2 2 2 7 8))
