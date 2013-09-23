(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (split behave1 behave2)
  (lambda (painter n)
	(if (= n 0)
	  painter
	  (let ((smaller ((split behave1 behave2) painter (- n 1))))
		(behave1 painter (behave2 smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split einstein 2))
(paint (up-split einstein 2))
