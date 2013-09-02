(define (sum term a next b)
  (if (> a b)
	0
	(+ (term a)
	   (sum term (next a) next b))))

(define (cube x) (* x x x))

(define (simpson f a b n)
  (define h (/ (- b a) n))

  (define (inc x)
	(+ x 1))

  (define (y k)
	(f (+ a (* k h))))

  (define (term k)
	(* (cond ((odd? k) 4)
			 ((or (= k 0) (= k n)) 1)
			 (else 2))
	   (y k)))

  (* (sum term 0.0 inc n)
	 (/ h 3.0)))

(simpson cube 0 1 100)
(simpson cube 0 1 1000)
