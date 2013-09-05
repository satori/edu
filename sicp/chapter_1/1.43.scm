(define (square x)
  (* x x))

(define (compose f g)
  (lambda (x)
	(f (g x))))

(define (repeated f n)
  (cond ((= n 1) f)
		(else (compose f (repeated f (- n 1))))))

((repeated square 2) 5)
((repeated square 3) 2)
