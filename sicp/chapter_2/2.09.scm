(define (make-interval a b)
  (cons a b))

(define (lower-bound i)
  (car i))

(define (upper-bound i)
  (cdr i))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
				 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
				 (- (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
		(p2 (* (lower-bound x) (upper-bound y)))
		(p3 (* (upper-bound x) (lower-bound y)))
		(p4 (* (upper-bound x) (upper-bound y))))
	(make-interval (min p1 p2 p3 p4)
				   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
				(make-interval (/ 1.0 (upper-bound y))
							   (/ 1.0 (lower-bound y)))))

(define (width-interval i)
  (/ (- (upper-bound i)
		(lower-bound i))
	 2))

(width-interval (make-interval 10 20))
(width-interval (make-interval 5 10))

(width-interval (add-interval (make-interval 10 20)
							  (make-interval 5 10)))

(width-interval (sub-interval (make-interval 10 20)
							  (make-interval 5 10)))

(width-interval (mul-interval (make-interval 10 20)
							  (make-interval 5 10)))

(width-interval (div-interval (make-interval 10 20)
							  (make-interval 5 10)))
