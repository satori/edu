(define (product term a next b)
  (if (> a b)
	1
	(* (term a)
	   (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
	(if (a > b)
	  result
	  (iter (next a) (* (term a) result))))

  (iter a 1))

(define (factorial n)
  (define (inc x)
	(+ x 1))

  (define (identity x) x)

  (product identity 1 inc n))

(define (wallis-pi n)
  (define (inc x)
	(+ x 1))

  (define (term k)
	(cond ((odd? k)
		   (/ (+ k 1)
			  (+ k 2)))
		  (else
			(/ (+ k 2)
			   (+ k 1)))))

  (* 4 (product term 1.0 inc n)))
