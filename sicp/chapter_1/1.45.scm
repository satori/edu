(define tolerance 0.00001)

(define (average x y)
  (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
	(< (abs (- v1 v2)) tolerance))

  (define (try guess)
	(let ((next (f guess)))
	  (if (close-enough? guess next)
		next
		(try next))))

  (try first-guess))

(define (compose f g)
  (lambda (x)
	(f (g x))))

(define (repeated f n)
  (cond ((= n 1) f)
		(else (compose f (repeated f (- n 1))))))

(define (log2 x)
  (/ (log x) (log 2)))

(define (nth-root x n)
  (fixed-point ((repeated average-damp (floor (log2 n)))
				 (lambda (y) (/ x (expt y (- n 1)))))
			   1.0))

(nth-root 4 2)
(nth-root 8 3)
(nth-root 16 4)
(nth-root 256 8)
(nth-root 65536 16)
