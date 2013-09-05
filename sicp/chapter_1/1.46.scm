(define (iterative-improve close-enough? improve)
  (lambda (guess)
	(if (close-enough? guess)
	  guess
	  ((iterative-improve close-enough? improve) (improve guess)))))

(define tolerance 0.00001)

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt x)
  ((iterative-improve
	 (lambda (guess) (< (abs (- (square guess) x)) tolerance))
	 (lambda (guess) (average guess (/ x guess))))
   1.0))

(define (fixed-point f first-guess)
  ((iterative-improve
	 (lambda (guess) (< (abs (- (f guess) guess)) tolerance))
	 f)
   first-guess))

(sqrt 9)
(sqrt 16)

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
