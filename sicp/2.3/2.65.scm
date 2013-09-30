(load "2.63.scm")
(load "2.64.scm")

(define (union-set tree1 tree2)
  (define (union-list set1 set2)
	(cond ((null? set1) set2)
		  ((null? set2) set1)
		  ((= (car set1) (car set2))
		   (cons (car set1) (union-list (cdr set1) (cdr set2))))
		  ((< (car set1) (car set2))
		   (cons (car set1) (union-list (cdr set1) set2)))
		  (else (cons (car set2) (union-list set1 (cdr set2))))))

  (list->tree (union-list (tree->list-2 tree1)
						  (tree->list-2 tree2))))

(union-set (list->tree (list 1 2 3 4 5))
		   (list->tree (list 4 5 6 7 8 9)))


(define (intersection-set tree1 tree2)
  (define (intersection-list set1 set2)
	(if (or (null? set1) (null? set2))
	  '()
	  (let ((x1 (car set1))
			(x2 (car set2)))
		(cond ((= x1 x2)
			   (cons x1
					 (intersection-list (cdr set1)
									   (cdr set2))))
			  ((< x1 x2)
			   (intersection-list (cdr set1) set2))
			  ((< x2 x1)
			   (intersection-list set1 (cdr set2)))))))

  (list->tree (intersection-list (tree->list-2 tree1)
								 (tree->list-2 tree2))))

(intersection-set (list->tree (list 1 2 3 4 5))
				  (list->tree (list 4 5 6 7 8 9)))
