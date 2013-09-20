(define (cont-frac n d k)
  (define (fraction i)
	(/ (n i) (+ (d i)
				(cond ((> i k) 0.0)
					  (else (fraction (+ i 1)))))))
  (fraction 1))

(define (euler-e n)
  (+ 2
	 (cont-frac (lambda (i) 1.0)
				(lambda (i)
				  (cond ((= 0 (remainder (+ i 1) 3))
						 (* 2.0 (/ (+ i 1) 3)))
						(else 1.0)))
				n)))

(euler-e 5)
(euler-e 10)
(euler-e 20)
