(define (filtered-accumulate combiner null-value term a next b filter?)
  (if (> a b)
	null-value
	(combiner (cond ((filter? a)
					 (term a))
					(else null-value))
			  (filtered-accumulate combiner null-value term (next a) next b filter?))))

(define (inc x)
  (+ x 1))

(define (sum-prime-squares a b)
  (define (square x)
	(* x x))

  (define (smallest-divisor n)
	(find-divisor n 2))

  (define (find-divisor n test-divisor)
	(define (next n)
	  (cond ((= n 2) 3)
			(else (+ n 2))))

	(cond ((> (square test-divisor) n) n)
		  ((divides? test-divisor n) test-divisor)
		  (else (find-divisor n (next test-divisor)))))

  (define (divides? a b)
	(= (remainder b a) 0))

  (define (prime? n)
	(= n (smallest-divisor n)))

  (filtered-accumulate + 0 square a inc b prime?))

(define (product-relative-prime n)
  (define (identity x) x)

  (define (filter? x)
	(= 1 (gcd n x)))

  (filtered-accumulate * 1 identity 1 inc (- n 1) filter?))
