(define (f n)
  (if (< n 3)
	n
	(+ (f (- n 1))
	   (* 2 (f (- n 2)))
	   (* 3 (f (- n 3))))))

(define (f n)
  (define (f-iter a b c count)
	(if (= count 0)
	  a
	  (f-iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))

	(f-iter 0 1 2 n))
