(define (cont-frac n d k)
  (define (fraction i)
	(/ (n i) (+ (d i)
				(cond ((> i k) 0)
					  (else (fraction (+ i 1)))))))

  (fraction 1))

(define (cont-frac-iter n d k)
  (define (iter i result)
	(if (= i 0)
	  result
	  (iter (- i 1) (/ (n i) (+ (d i) result)))))
  
  (iter k 1))

(cont-frac (lambda (i) 1.0)
		   (lambda (i) 1.0)
		   5)

(cont-frac (lambda (i) 1.0)
		   (lambda (i) 1.0)
		   10)

(cont-frac (lambda (i) 1.0)
		   (lambda (i) 1.0)
		   40)
