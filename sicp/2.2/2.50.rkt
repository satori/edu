(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (flip-horiz painter)
  ((transform-painter (make-vect 1.0 0.0)
					  (make-vect 0.0 0.0)
					  (make-vect 1.0 1.0))
   painter))

(paint (flip-horiz einstein))

(define (rotate180 painter)
  ((transform-painter (make-vect 1.0 1.0)
					  (make-vect 0.0 1.0)
					  (make-vect 1.0 0.0))
   painter))

(paint (rotate180 einstein))

(define (rotate270 painter)
  ((transform-painter (make-vect 0.0 1.0)
					  (make-vect 0.0 0.0)
					  (make-vect 1.0 1.0))
   painter))

(paint (rotate270 einstein))
