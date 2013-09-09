(define (make-interval a b)
  (cons a b))

(define (lower-bound i)
  (car i))

(define (upper-bound i)
  (cdr i))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
		(p2 (* (lower-bound x) (upper-bound y)))
		(p3 (* (upper-bound x) (lower-bound y)))
		(p4 (* (upper-bound x) (upper-bound y))))
	(make-interval (min p1 p2 p3 p4)
				   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (cond ((and (<= (lower-bound y) 0)
			  (>= (upper-bound y) 0))
		 (error "Error: Interval bounds should not span 0."))
		(else (mul-interval x
							(make-interval (/ 1.0 (upper-bound y))
										   (/ 1.0 (lower-bound y)))))))

(div-interval (make-interval 10 20) (make-interval -5 5))
