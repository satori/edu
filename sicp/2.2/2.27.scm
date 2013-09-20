(define (deep-reverse items)
  (if (pair? items)
	(map deep-reverse (reverse items))
	items))

(define x (list (list 1 2) (list 3 4)))

(reverse x)
(deep-reverse x)
