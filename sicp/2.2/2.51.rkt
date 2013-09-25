(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (below painter1 painter2)
  (let ((paint-bottom
		  ((transform-painter (make-vect 0.0 0.0)
							  (make-vect 1.0 0.0)
							  (make-vect 0.0 0.5))
		   painter1))
		(paint-top
		  ((transform-painter (make-vect 0.0 0.5)
							  (make-vect 1.0 0.5)
							  (make-vect 0.0 1.0))
		   painter2)))
	(lambda (frame)
	  (paint-bottom frame)
	  (paint-top frame))))

(paint (below einstein einstein))

(define (below painter1 painter2)
  (rotate270 (beside (rotate90 painter1) (rotate90 painter2))))

(paint (below einstein einstein))
