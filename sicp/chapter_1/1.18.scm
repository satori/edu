(define (even? n)
  (= (remainder n 2) 0))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (mul a b)
  (define (mul-iter a b p)
	(cond ((= b 0) p)
		  ((even? b) (mul-iter (double a) (halve b) p))
		  (else (mul-iter a (- b 1) (+ a p)))))

  (mul-iter a b 0))
