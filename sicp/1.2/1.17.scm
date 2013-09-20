(define (even? n)
  (= (remainder n 2) 0))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (fast-mul a b)
	(cond ((= b 0) 0)
		  ((even? b) (fast-mul (double a) (halve b)))
		  (else (+ a (fast-mul a (- b 1))))))
