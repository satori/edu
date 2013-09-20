(define (square x) (* x x))

(define (abs x)
  (if (< x 0)))

(define (cbrt x)
  (define (improve guess)
	(/ (+ (/ x (square guess))
		  (* 2 guess))
	   3))

  (define (good-enough? guess previous-guess)
	(< (abs (- guess previous-guess)) .001))

  (define (cbrt-iter guess previous-guess)
	(if (good-enough? guess previous-guess)
	  guess
	  (cbrt-iter (improve guess) guess)))

  (cbrt-iter 1.0 0))
