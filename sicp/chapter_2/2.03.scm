(define (square x)
  (* x x))

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-segment start end)
  (cons start end))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (length-segment s)
  (sqrt (+ (square (- (x-point (start-segment s))
					  (x-point (end-segment s))))
		   (square (- (y-point (start-segment s))
					  (y-point (end-segment s)))))))

(define (make-rectangle north-east-corner south-west-corner)
  (cons north-east-corner south-west-corner))

(define (north-east-rectangle r)
  (car r))

(define (south-west-rectangle r)
  (cdr r))

(define (width-rectangle r)
  (abs (- (x-point (north-east-rectangle r))
		  (x-point (south-west-rectangle r)))))

(define (height-rectangle r)
  (abs (- (y-point (north-east-rectangle r))
		  (y-point (south-west-rectangle r)))))

(define (perimeter-rectangle r)
  (* 2
	 (+ (width-rectangle r)
		(height-rectangle r))))

(define (area-rectangle r)
  (* (width-rectangle r)
	 (height-rectangle r)))

(define rect (make-rectangle (make-point 10 10) (make-point 20 20)))

(perimeter-rectangle rect)
(area-rectangle rect)


(define (make-rectangle x-segment y-segment)
  (cons x-segment y-segment))

(define (x-segment r)
  (car r))

(define (y-segment r)
  (cdr r))

(define (width-rectangle r)
  (length-segment (x-segment r)))

(define (height-rectangle r)
  (length-segment (y-segment r)))

(define rect (make-rectangle (make-segment (make-point 10 10) (make-point 10 20))
							 (make-segment (make-point 20 10) (make-point 20 20))))

(perimeter-rectangle rect)
(area-rectangle rect)
