(define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (abs x)
  (if (< x 0)
	(- x)
	x))

(define (sqrt x)
  (define (improve guess)
	(average guess (/ x guess)))

  (define (good-enough? guess previous-guess)
	(< (abs (- guess previous-guess)) .001))

  (define (sqrt-iter guess previous-guess)
	(if (good-enough? guess previous-guess)
	  guess
	  (sqrt-iter (improve guess) guess)))

  (sqrt-iter 1.0 0))
