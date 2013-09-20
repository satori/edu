(define (average x y)
  (/ (+ x y) 2))

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

(define (midpoint-segment s)
  (make-point (average (x-point (start-segment s))
					   (x-point (end-segment s)))
			  (average (y-point (start-segment s))
					   (y-point (end-segment s)))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define point-p (make-point 1 2))
(define point-q (make-point 2 3))
(define seg (make-segment point-p point-q))

(print-point (midpoint-segment seg))
