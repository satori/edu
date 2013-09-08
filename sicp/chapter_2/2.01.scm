(define (make-rat n d)
  (let ((g (gcd n d))
		(sign (if (< d 0) -1 1)))
	(cons (* sign (/ n g))
		  (abs (/ d g)))))

(define (numer x)
  (car x))

(define (denom x)
  (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(print-rat (make-rat -1 -2))
(print-rat (make-rat -1 2))
(print-rat (make-rat 1 -2))
