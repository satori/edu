(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define outline-segments
  (list
	(make-segment
	  (make-vect 0.0 0.0)
	  (make-vect 0.0 0.99))
	(make-segment
	  (make-vect 0.0 0.0)
	  (make-vect 0.99 0.0))
	(make-segment
	  (make-vect 0.0 0.99)
	  (make-vect 0.99 0.99))
	(make-segment
	  (make-vect 0.99 0.0)
	  (make-vect 0.99 0.99))))

(define outline (segments->painter outline-segments))

(paint outline)

(define cross-segments
  (list
	(make-segment
	  (make-vect 0.0 0.0)
	  (make-vect 0.99 0.99))
	(make-segment
	  (make-vect 0.0 0.99)
	  (make-vect 0.99 0.0))))

(define cross (segments->painter cross-segments))

(paint cross)

(define diamond-segments
  (list
	(make-segment
	  (make-vect 0.5 0.0)
	  (make-vect 0.0 0.5))
	(make-segment
	  (make-vect 0.0 0.5)
	  (make-vect 0.5 0.999))
	(make-segment
	  (make-vect 0.5 0.999)
	  (make-vect 0.999 0.5))
	(make-segment
	  (make-vect 0.999 0.5)
	  (make-vect 0.5 0.0))))

(define diamond (segments->painter diamond-segments))

(paint diamond)

(define wave-segments
  (list
	(make-segment
	  (make-vect 0.0 0.8)
	  (make-vect 0.2 0.6))
	(make-segment
	  (make-vect 0.2 0.6)
	  (make-vect 0.3 0.65))
	(make-segment
	  (make-vect 0.3 0.65)
	  (make-vect 0.4 0.65))
	(make-segment
	  (make-vect 0.4 0.65)
	  (make-vect 0.35 0.85))
	(make-segment
	  (make-vect 0.35 0.85)
	  (make-vect 0.4 0.99))
	(make-segment
	  (make-vect 0.0 0.6)
	  (make-vect 0.2 0.4))
	(make-segment
	  (make-vect 0.2 0.4)
	  (make-vect 0.3 0.55))
	(make-segment
	  (make-vect 0.3 0.55)
	  (make-vect 0.34 0.5))
	(make-segment
	  (make-vect 0.34 0.5)
	  (make-vect 0.27 0.0))
	(make-segment
	  (make-vect 0.6 0.99)
	  (make-vect 0.65 0.85))
	(make-segment
	  (make-vect 0.65 0.85)
	  (make-vect 0.6 0.65))
	(make-segment
	  (make-vect 0.6 0.65)
	  (make-vect 0.75 0.65))
	(make-segment
	  (make-vect 0.75 0.65)
	  (make-vect 0.99 0.3))
	(make-segment
	  (make-vect 0.73 0.0)
	  (make-vect 0.6 0.5))
	(make-segment
	  (make-vect 0.6 0.5)
	  (make-vect 0.99 0.15))
	(make-segment
	  (make-vect 0.4 0.0)
	  (make-vect 0.5 0.25))
	(make-segment
	  (make-vect 0.5 0.25)
	  (make-vect 0.6 0.0))))

(define wave (segments->painter wave-segments))

(paint wave)
