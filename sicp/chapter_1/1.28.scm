(define (expmod base exp m)
  (define (square-check x)
	(if (and (not (or (= x 1) (= x (- m 1))))
			 (= (remainder (square x) m) 1))
	  0
	  (remainder (square x) m)))

  (cond ((= exp 0) 1)
		((even? exp)
		 (square-check (expmod base (/ exp 2) m)))
		(else
		  (remainder (* base (expmod base (- exp 1) m)) m))))

(define (miller-rabin-test n)

  (define (try-it a)
	(= (expmod a (- n 1) n) 1))

  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
		((miller-rabin-test n) (fast-prime? n (- times 1)))
		(else false)))

(fast-prime? 199 100)

(fast-prime? 561 100)

(fast-prime? 1105 100)

(fast-prime? 1729 100)

(fast-prime? 1999 100)

(fast-prime? 2465 100)

(fast-prime? 2821 100)

(fast-prime? 6601 100)
